function [DG, NG, sNG] = getGeometricContourCues(im, x3, y3, z3)
    disk_radius = 5;
    disk_orient = 20;
    
    h = size(im,1);
    w = size(im,2);
    
    max_plane_fitting_dist = 10; %in metres
    
    im_new = [zeros(disk_radius, w+2*disk_radius);...
              zeros(h, disk_radius), im, zeros(h, disk_radius);...
              zeros(disk_radius, w+2*disk_radius)];
    x_pc = [zeros(disk_radius, w+2*disk_radius);...
              zeros(h, disk_radius), x3, zeros(h, disk_radius);...
              zeros(disk_radius, w+2*disk_radius)];
    y_pc = [zeros(disk_radius, w+2*disk_radius);...
              zeros(h, disk_radius), y3, zeros(h, disk_radius);...
              zeros(disk_radius, w+2*disk_radius)];
    z_pc = [zeros(disk_radius, w+2*disk_radius);...
              zeros(h, disk_radius), z3, zeros(h, disk_radius);...
              zeros(disk_radius, w+2*disk_radius)];
    X_pc = cat(3, x_pc, y_pc, z_pc);
    
    DG = zeros(h,w);
    NG = zeros(h,w);
    sNG = zeros(h,w);
    
    for i=1+disk_radius:h+disk_radius
        for j=1+disk_radius:w+disk_radius
            %Currently a square not a disk
            disk = im_new(i + (-disk_radius:disk_radius), j + (-disk_radius:disk_radius));
            disk_rot = imrotate(disk, disk_orient);
            %Crop the same part of coordinates
            X = X_pc(i + (-disk_radius:disk_radius), j + (-disk_radius:disk_radius),:);
            
            %Convert pointclouds to within 0 and 1
            X_min = min(min(X));
            X_max = max(max(X));
            X_new = (X - repmat(X_min, [size(X,1), size(X,2), 1]))...
                    ./(repmat(X_max - X_min, [size(X,1), size(X,2), 1]));
                
            %Rotate pointcloud
            X_rot = imrotate(X_new, disk_orient);
            %Change from 0-1 to original range
            % converted to 0-1 for imrotate to function properly
            X_rot = X_rot.*(repmat(X_max - X_min, [size(X,1), size(X,2), 1]))...
                    + repmat(X_min, [size(X,1), size(X,2), 1]);
            %Split disk and point clouds    
            w_new = size(disk_rot,2);
            
            disk_rot_l = disk_rot(:,1:floor(w_new/2));
            disk_rot_r = disk_rot(:,ceil(w_new/2):w_new);
            
            X_rot_l = X_rot(:,1:floor(w_new/2),:);
            X_rot_r = X_rot(:,ceil(w_new/2):w_new);
            
            %Find planes fitting the pointclouds
            X_rot_l_pc = pointCloud(X_rot_l);
            X_rot_r_pc = pointCloud(X_rot_r);
            plane_l = pcfitplane(X_rot_l_pc, max_plane_fitting_dist);
            plane_r = pcfitplane(X_rot_r_pc, max_plane_fitting_dist);
            
            %Evaluate the planes at the disk centre
            x = X_pc(i,j,1);
            y = X_pc(i,j,2);
            %Substitute x and y in equation of plane_l to get z
            z_l = (plane_l.Parameters(1:4)*[-x, -y, 0, -1]')/plane_l.Parameters(3);
            z_r = (plane_r.Parameters(1:4)*[-x, -y, 0, -1]')/plane_r.Parameters(3);
            %Use this point to find distance from plane r and store in DG
            DG(i-disk_radius, j-disk_radius) = abs(plane_l.Parameters*[x,y,z_l,1]')/norm(plane_r.Parameters(1:3));
            
            %Calculate distance between normals and save in NG+ and NG-
            NG(i-disk_radius, j-disk_radius) = 1-atan2(norm(cross(plane_l.Normal, plane_r.Normal)), dot(plane_l.Normal, plane_r.Normal));
            
            %Find sign
            displ_vect = [0; 0; z_r - z_l];
            %Compare angle between the vector joining Normals and the
            %vector joining 2 points on the 2 planes
            sNG(i-disk_radius, j-disk_radius) = sign((plane_r.Normal - plane_l.Normal)*(displ_vect));
        end
    end
end 
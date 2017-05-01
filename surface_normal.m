function [ image_new ] = surface_normal(image,cons)
%Compute geocentric cordinate frame
%input: 2D Depth Image
%output:

%% Compute surface normal
t = 1; 
image = double(image);
%gradient accross these many pixels

% image_new = image;
for i = 1 :size(image,1)
    for j = 1:size(image,2)
        if i-cons <= 0 | i+cons > size(image,1) | j-cons <= 0 | j+cons >size(image,2)
%             image_new(i,j,:) = [0 0 1];
            continue
        end
        grad_x = (image(i+cons,j) - image(i-cons,j))/(2*cons);
        grad_y = (image(i,j+cons) - image(i,j-cons))/(2*cons);
        
        norm_vec = [-grad_x,-grad_y,1];
        normal = norm_vec/norm(norm_vec);
        image_new(i,j,:) = normal;

%         image_normal{i,j} = normal;
%         a = image_normal{i,j};
%         vecs(t,:) = a(:); 
%         t = t+1;
    end
end

end


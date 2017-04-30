function [ normals ] = compute_pointCloud( imName )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

name = strcat('data/pointCloud/',imName,'.mat');
load(name);
[n1,n2,n3] = surfnorm(x3,y3,z3);
normals = cat(3,n1,n2,n3);

%%If want to display it 
% pc = cat(3,x3,y3,z3);
% ptCloud = pointCloud(pc);
% showPointCloud(ptCloud);

end


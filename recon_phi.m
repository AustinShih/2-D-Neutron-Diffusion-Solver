function [ phi_recon ] = recon_phi( phi )
% Reconstruct phi matrix into two dimensions to plot

[N,~] = size(phi);
sqr_N = sqrt(N);
phi_recon = reshape(phi,[sqr_N,sqr_N]);


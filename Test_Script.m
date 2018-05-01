%%% Final Project Test %%%

[geo, mesh] = FP_155_import_geo();
[sig_F, sig_A, D] = data(geo);
[coef_mat, cell_mat] = FP_155_gen_mat(geo, sig_F, sig_A, D); % A
% given coefficient matrix solve for phi using jacobi
% must first build phi matrix, assume 0 source terms
[N, M] = size(D); 
S_mat = zeros(N*M,1); % b
% build phi mat
phi_mat = ones(N*M,1); % x
ep = 1.0E-7;
[s1] = iter_jac(coef_mat,S_mat,phi_mat,ep);
% split s1 into multiple matrices
% solve 
% write function to reconstruct phi matrix
s1 = recon_phi(s1);
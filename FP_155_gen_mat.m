function [ coef_matrix, cell_array ] = FP_155_gen_mat(input_geo , ...
    sig_f,sig_a,D)
    % FP_155_gen_mat will generate coefficient matrix for the given problem
    % See Derivation document for explanation as to where derivation 
    % is from.
    
% require symmetric step size in x and y --> epsilon = delta = h
    
% Expect a banded matrix

[N , M] = size(input_geo);  % get rows and columns of input geo
    % N is rows
    % M is columns
% Say 0,0 cell is bottom left corner (1,1) is bottom left corner due to
% indexing conventions
coef_cell = cell(N,M);
for i = 1:N % index through rows
    for j = 1:M % index through columns
            % make center matrices, side matrices, then concat into one
            % matrix
            if i-j == 0
                coef_cell{i,j} = center_matrix(N,i,j,sig_a,sig_f,D); %populate center matrix
            elseif i-j == -1
                coef_cell{i,j} = right_matrix_mk2(N,i,j,D); %populate right matrix
            elseif i-j == 1
                coef_cell{i,j} = left_matrix_mk2(N,i,j,D); %populate left matrix
            else
                coef_cell{i,j} = zeros(N,M);
            end
    end
end
cell_array = coef_cell;
coef_matrix = cell2mat(coef_cell);


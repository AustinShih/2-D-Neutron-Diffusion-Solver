function [ coef_matrix ] = FP_155_gen_mat(input_geo)
    % FP_155_gen_mat will generate coefficient matrix for the given problem
    % See Derivation document for explanation as to where derivation 
    % is from.
    
% require symmetric step size in x and y --> epsilon = delta = h
    
% Expect a banded matrix

% Define equations using anonymous functions

a_im1j = @(Dij,Dip1) -(Dij*epsilon + Dijp1)/2;
    % a_im1j corresponds to coefficient a_i-1,j or in words
        % a with subscripts "i" minus 1, "j"
        % caputres influence of left flux on center cell
    % Dij is D at "i" and "j"
    % Dijp1 is D at "i" and "j + 1" 
        
a_ip1j = @(Dip1j,Dip1jp1) -(Dip1j + Dip1jp1)/2;
    % a_ip1j corresponds to coefficient a_i+1,j
        % caputres influence of right flux on center cell
    % Dip1j is D at "i + 1" and "j"
    % Dip1jp1 is D at "i + 1" and "j + 1"
    
a_ijm1 = @(Dij,Dip1j) -(Dij + Dip1j)/2;
    % a_ijm1 corresponds to coefficient a_i,j-1
        % captures influence or lower flux on center cell
    % Dij is D at "i" and "j"
    % Dip1j is D at "i + 1" and "j"

a_ijp1 = @(Dijp1,Dip1jp1) -(Dijp1 + Dip1jp1)/2;
    % a_ijp1 corresponds to coefficient a_i,j+1
        % captures influence of upper flux on center cell
    % Dijp1 is D at "i" and "j+1"
    % Dip1jp1 is D at "i + 1" and "j + 1"
    
a_ij = @(Sigma_Absorb_ij, nu, Sigma_Fission_ij, a_im1j, a_ip1j, ... 
    a_ijm1, a_ijp1) ...
    (Sigma_Absorb_ij - nu*Sigma_Fission_ij) - (a_im1j + a_ip1j + ...
                                               a_ijm1 + a_ijp1);
    % a_ij corresponds to coefficient a_ij
        % captures influence on center cell
[N , M] = size(input_geo);  % get rows and columns of input geo
    % N is rows
    % M is columns
% Say 0,0 cell is bottom left corner (1,1) is bottom left corner due to
% indexing conventions
coef_cell = cell(N,M);
for i = 1:N % index through rows
    for j = 1:M % index through columns
        for k = 1:M % indicates number of different matrices we will have
            % make center matrices, side matrices, then concat into one
            % matrix
            if i-j == 0
                coef_cell{i,j} = rand(N,M); %populate center matrix
            elseif i-j == -1
                coef_cell{i,j} = ones(N,M); %populate right matrix
            elseif i-j == 1
                coef_cell{i,j} = magic(N,M); %populate left matrix
            else
                coef_cell{i,j} = zeros(N,M);
            end
        end
    end
end
coef_matrix = cell2mat(coef_cell);
    
end


function [ mat_out ] = left_matrix_mk2(N, i, j, D)
% Populates left matrix of diffusion matrix
        % N is the size
        % i and j are the current indices
        % sig_f is matrix of fission cross-section values that is imported
        % sig_a is matrix of absorption cross-section values
        % D is diffusion constant values
% the lower index is the cell to which you are coupling, the upper index
% is the cell you are in

a_ip1j = @(i,j,D) -(D(i+1,j) + D(i+1,j+1))/2;
    % a_ip1j corresponds to coefficient a_i+1,j
        % caputres influence of right flux on center cell
    % Dip1j is D at "i + 1" and "j"
    % Dip1jp1 is D at "i + 1" and "j + 1"
    
a_ijm1 = @(i,j,D) -(D(i,j) + D(i+1,j))/2;
    % a_ijm1 corresponds to coefficient a_i,j-1
        % captures influence or lower flux on center cell
    % Dij is D at "i" and "j"
    % Dip1j is D at "i + 1" and "j"
    
mat = zeros(N,N);
D = flipud(D);
for k = 1:N
    for l = 1:N
        if k == l
            if k == 1
                mat(k,l) = a_ip1j(j,k,D); % left boundary condition
            elseif k == N
                mat(k,l) = -D(j,k); % right boundary condition
            elseif j == 1
                mat(k,l) = a_ijm1(j,k,D); % bottom boundary condition
            else
                mat(k,l) = a_ijm1(j,k,D); %column index is advancing
            end
        end
    end
end
mat_out = mat;
end
function [ mat_out ] = right_matrix_mk2(N, i, j, D)
    % Populates right matrix of diffusion matrix
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

a_ijp1 = @(i,j,D) -(D(i,j+1) + D(i+1,j+1))/2;
    % a_ijp1 corresponds to coefficient a_i,j+1
        % captures influence of upper flux on center cell
    % Dijp1 is D at "i" and "j+1"
    % Dip1jp1 is D at "i + 1" and "j + 1"
mat = zeros(N,N);
D = flipud(D);
for k = 1:N
    for l = 1:N
        if k-l == 0
            if (k == N && j ~= N)
                % Right boundary condition
                mat(k,l) = -(D(k,j+1) + D(k-1,j+1))/2;
            elseif (k == N && j == N)
                % Top Right Corner boundary condition
                mat(k,l) = -(D(k,j-1) + D(k-1,j-1))/2; % top boundary contion
             elseif (k ~= N && j == N)
                % Top Boundary Condition
                mat(k,l) = -(D(k,j-1)+D(k+1,j-1))/2;
            else
                mat(k,l) = a_ijp1(j,k,D); %column index is advancing
            end
        end
    end
end
mat_out = mat;
end


function [ center_matrix ] = center_matrix(N, i ,j ,sig_a ,sig_f , D)
%Populates left matrix of diffusion matrix
        % N is the size
        % i and j are the current indices
        % sig_f is matrix of fission cross-section values that is imported
        % sig_a is matrix of absorption cross-section values
        % D is diffusion constant values
% the lower index is the cell to which you are coupling, the upper index
% is the cell you are in

a_im1j = @(i,j,D) -(D(i,j) + D(i,j+1))/2;
    % a_im1j corresponds to coefficient a_i-1,j or in words
        % a with subscripts "i" minus 1, "j"
        % caputres influence of left flux on center cell
    % Dij is D at "i" and "j"
    % Dijp1 is D at "i" and "j + 1" 
        
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
    
a_ijm1 = @(i,j,D) -(D(i,j) + D(i+1,j))/2;
    % a_ijm1 corresponds to coefficient a_i,j-1
        % captures influence or lower flux on center cell
    % Dij is D at "i" and "j"
    % Dip1j is D at "i + 1" and "j"
    
a_ij = @(Sigma_Absorb_ij, nu, Sigma_Fission_ij, a_im1j, a_ip1j, ... 
    a_ijm1, a_ijp1) ...
    (Sigma_Absorb_ij - nu*Sigma_Fission_ij) - (a_im1j + a_ip1j + ...
                                               a_ijm1 + a_ijp1);
    % a_ij corresponds to coefficient a_ij
        % captures influence on center cell
nu = 2.4;
mat = zeros(N,N);
D = flipud(D);
sig_a = flipud(sig_a);
sig_f = flipud(sig_f);
for k = 1:N % indexes rows
    for l = 1:N % indexes columns
        if k-l == 0 % diagonal
            % note: i and j have same value in this function
            
            if ( k == 1 && j ~= 1 && j ~=N )
                % Left Boundary condition and not corner
                mat(k,l) = a_ij( sig_a(k,i), nu , sig_f(k,i) , ... 
                     a_im1j(k,j,D),... left
                     0,... right 
                     0,... lower 
                     0); % top
                 
            elseif (k == N && j ~= 1 && j ~= N) 
                % Right Boundary condition and not corner
                mat(k,l) = a_ij( sig_a(k,i), nu , sig_f(k,i) , ... 
                     a_im1j(k,j,D),... left
                     a_im1j(k,j,D),... right 
                     -D(k,j-1),... lower 
                     -D(k,j)); % top
                 
            elseif (j == 1 && k ~= N && k ~= 1 )
                % Bottom Boundary condition and not corner
                mat(k,l) =  a_ij( sig_a(k,i), nu , sig_f(k,i) , ... 
                     0,... left
                     0,... right 
                     0,... lower 
                     a_ijp1(k,j,D)); % top
                 
            elseif (j == N && k ~= N && k ~= 1 )
                % Top Boundary condition and not corner
                 mat(k,l) = a_ij( sig_a(k,i), nu , sig_f(k,i) , ... 
                     -D(k,j),... left
                     -D(k+1,j),... right 
                     a_ijm1(k,j,D),... lower 
                     a_ijm1(k,j,D)); % top
                
            elseif (j == 1 && k == 1)
                % Bottom left corner
                % bottom left corner is arbitrary since all flux values
                %   are 0
                mat(k,l) = 1;
            elseif (j == 1 && k == N) 
                % Bottom right corner
                mat(k,l) = a_ij( sig_a(k,i), nu , sig_f(k,i) , ... 
                     a_im1j(k,j,D),... left ||| stay 
                     a_im1j(k,j,D),... right 
                     0,... lower 
                     -D(k,j+1)); % top
            elseif (j == N && k == 1)
                % Top left corner
                mat(k,l) = a_ij( sig_a(k,i), nu , sig_f(k,i) , ... 
                     0,... left
                     -D(k+1,j),... right 
                     a_ijm1(k,j,D),... lower 
                     a_ijm1(k,j,D)); % top
            elseif (j == N && k == N)
                % Top right corner
                mat(k,l) = a_ij( sig_a(k,i), nu , sig_f(k,i) , ... 
                     -2*D(k,j-1),...
                     -2*D(k-1,j),... right 
                     0,... lower 
                     0); % top
            else 
                 mat(k,l) = a_ij( sig_a(k,i), nu , sig_f(k,i) , ... 
                     a_im1j(k,j,D),... left
                     a_ip1j(k,j,D),... right 
                     a_ijm1(k,j,D),... lower 
                     a_ijp1(k,j,D)); % top
                        % note that i changes and j is constant            
            end
            
        elseif k-l == -1 % right of center values
            
            
%             if l == N % left boundary conditions
%                 mat(k,l) = 1;
%             elseif j == 1
%                 mat(k,l) = 1; % bottom boundary conditions
            if j == N
                mat(k,l) = -D(k,j-1); % top boundary conditions
            else
                mat(k,l) = a_ip1j(k,j,D);
            end
            
        elseif k-l == 1 % left of center values
            
            
%             if l == 1   
%                 mat(k,l) = 1; % left boundary condition
%             elseif j == 1
%                 mat(k,l) = 1; % bottom boundary condition
            if j == N 
                mat(k,l) = a_ijm1(l,j,D); % top boundary condition
            else
                mat(k,l) = a_im1j(l,j,D);
            end
        end
    end
end
center_matrix = mat;
end


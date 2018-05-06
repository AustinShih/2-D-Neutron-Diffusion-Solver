function [ gs_m ] = gs_m( A, b, x_0, epsilon  )
%Implement vector solutions of iterative solution methods to reduce
%copuation time.

% Return values
    % gauss_seidel_m    returns solution of matrix using Gauss Siedel
    % num_iters_gs      returns number of iterations required for GS
    
% Input values
    % A                 coefficient matrix to be solved
    % b                 solution matrix
    % x_0               initial guess
    % omega             omega value for SOR
    % epsilon           acceptable error

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Universal Variables %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

[M,N] = size(A);    % use to create vectors of approriate size
i_L = 1.0E4;        % define iteration limit 


j = 1; 
gs_0 = x_0;
gs_step = zeros(M,1);
omega = 1;
    while j < i_L
        % Define gs_step
        for i = 1:M
            gs_step(i) = (1-omega)*gs_0(i)+((omega/A(i,i))*(b(i)-...
                (A(i,[1:i-1])*gs_step([1:i-1])) - ...
                (A(i,[i+1:N])*gs_0([i+1:N]))));
        end
        error_gs = norm(gs_step - gs_0)/norm(gs_step);
            if error_gs <epsilon
                gs_m = gs_step;
                num_iters_gs = j;
                break
            end
        j = j+1;
        gs_0 = gs_step;
    end


end


function [sigma_f,sigma_a,D] = data(A)
%Takes input material matrix and returns macroscopic fission and absorption
%cross sections, and the diffusion coefficient
q=size(A);
sigma_f=zeros(q);
sigma_a=zeros(q);
D=zeros(q);
for i=1:q(1)
    for j=1:q(2)
        if A(i,j)==0;
            sigma_f(i,j)=0;
        elseif A(i,j)== 235.025;
            sigma_f(i,j)=0.35869;
        elseif A(i,j)==235.1
            sigma_f(i,j)=1.436;
        elseif A(i,j)==235.9
            sigma_f(i,j)=12.924;
        elseif A(i,j)==40;
            sigma_f(i,j)=0;
        else disp('Invalid Material')
        end
    end
end
for i=1:q(1)
    for j=1:q(2)
        if A(i,j)==0;
            sigma_a(i,j)=0.0222;
        elseif A(i,j)== 235.025;
            sigma_a(i,j)=0.1232;
        elseif A(i,j)==235.1
            sigma_a(i,j)=0.3022;
        elseif A(i,j)==235.9
            sigma_a(i,j)=2.195;
        elseif A(i,j)==40;
            sigma_a(i,j)=0.0001773;
        else disp('Invalid Material')
        end
    end
end
  for i=1:q(1)
    for j=1:q(2)
        if A(i,j)==0;
            D(i,j)=0.1555;
        elseif A(i,j)== 235.025;
            D(i,j)=1.1592;
        elseif A(i,j)==235.1
            D(i,j)=0.7761;
        elseif A(i,j)==235.9
            D(i,j)=0.6351;
        elseif A(i,j)==40;
            D(i,j)=4.317;
        else disp('Invalid Material')
        end
    end
  end

end


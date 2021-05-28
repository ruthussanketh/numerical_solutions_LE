% Sample:
% "Enter the number of equations: " n = 3
% "Enter the equations as a matrix of " + n + " by " + m + ": " [1 3 1 10; 1 -2 -1 -6; 2 1 2 10]
% The solution vector is: 
%    0.6000    1.0000    0.4000

prompt1 = ("Enter the number of equations: ");
n = input(prompt1);
m = n+1;
prompt2 = ("Enter the equations as a matrix of " + n + " by " + m + ": ");
x = input(prompt2);
[y] = gauss_jordan_elim(x, n);
disp("The solution vector is: ");
disp(y);

function [sol] = gauss_jordan_elim (x, n)    
    for i = 1:n
        A = x(i,:);
        A = A/A(i);
        x(i,:) = A;
        
        for k = 1:n
            if i~=k
                x(k,:) = A*(-1*x(k,i)) + x(k,:);
            end
        end
    end
    
    sol = x(:,n+1)';
end

prompt1 = "Enter the order of the square matrix of the LHS of the equations: ";
n = input(prompt1);
prompt2 = "Enter matrix A row-wise: ";
A = input(prompt2);
prompt3 = "Enter matrix b as a column vector: ";
b = input(prompt3);

flag = check_dom(A,n);
if flag == 1
    x = sor_iter(A,b,n);
else
    A = make_dom(A,n);
    x = sor_iter(A,b,n);
end

disp('The solution to the system of equations using SOR iteration method is: ');
disp(x);

% checks if the matrix A is diagonally dominant
function flag = check_dom(A,n)
flag = 1;
for i = 1:n
    diag_sum = 0;
    for j = 1:n
        if i~=j
            diag_sum = diag_sum + A(i,j);
        end
    end
    if diag_sum > A(i,i)
        flag = flag*0;
    end
end
end

% performs jacobi iteration
function x = sor_iter(A,b,n)
x = zeros(n, 1);
R = zeros(n, 1);
del = 0.00001;
delta = 1;

while delta > del
    X = x';
    for i = 1:n
        sum = 0;
        for j = 1:n
            sum = sum + A(i,j)*x(j);
        end
        R(i,1) = b(i) - sum;
        %omega is taken to be 1.2
        x(i,1) = x(i,1) + 1*R(i,1)/A(i,i);
    end
    disp(R);
    disp(x');
    delta = abs(x' - X);
end
end

% makes matrix A dominant, if possible
function A = make_dom(A,n)
[max_value,index] = max(A,[],2);
sum = 0;
for i = 1:n
    for j = 1:n
        if j ~= index(i)
            sum = sum + A(i,j);
        end
    end
    if sum > max_value(i)
        disp("This matrix cannot be made diagonally dominant.")
        % if the sum of all elements except the max element in a row is bigger 
        % than the max element, then it cannot be made diagonally dominant.
        return
    end
end

for i = 1:n-1
    for j = i+1:n
        if index(i) == index(j)
            disp("This matrix cannot be made diagonally dominant.")
            % if the index of max elements of any 2 rows are the same, then
            % the matrix cannot be made diagonally dominant.
            return
        end
    end
end

for i = 1:n
    if index(i) ~= i
        temp = A(index(i),:);
        A(index(i),:) = A(i,:);
        A(i,:) = temp;
    end
    [~,index] = max(A,[],2);
end
end
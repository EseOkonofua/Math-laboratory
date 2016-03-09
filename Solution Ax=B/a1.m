%Function to find complete sol'n Ax = b;

%Inputs: A (m*m matrix), b(vector size m)
%m >= 1,m <= 10

%Outputs: Bspace (solution, column vector), Nspace (null solution,matrix)
function [Bspace,Nspace] = a1(A,b)
m = size(A,1); %check for m

if m < 1 || m > 10 %check size validity
    disp('Parameter A is invalid!');
else %***************main section******************
    %find Bspace
    ref = rref([A b]);
    Bspace = ref(:,m+1);
    %find Nspace
    if rref(A) == eye(m)
        Nspace = zeros(m,1);
    else
        Nspace = null(A,'r');
    end 
end % end size check



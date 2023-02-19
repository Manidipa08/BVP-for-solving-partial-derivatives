//uxx+uyy=0 on R={(x,y)|0<x<1,0<y<1}
clc
clear
function r_b = bottom(x,y)
    y=0
    r_b = 0
endfunction
function r_l = left(x,y)
    x=0
    r_l = y./(1.+y.^2)
endfunction
function r_t = top(x,y)
    y=1
    r_t=1./((1.+x).^2.+1)
endfunction
function r_r = right(x,y)
    x=1
    r_r=y./(4.+y.^2)
endfunction
function r_rhs=r(x,y)
    r_rhs=0
endfunction
x0=0
xn=1
y0=0
yn=1
n=input("No.of division along x axis : ")
h=(xn-x0)/n
disp("No. of intervals along y axis : ")
m=(yn-y0)/h
disp(m)
x=x0:h:xn
y=y0:h:yn
//disp([x y])
D =zeros (n+1,n+1)//Diagonal matrix
for i=1:n+1//calculating the diagonal matrix
    if i==1
        D(i,i)=4
        D(i,i+1)=-1
    elseif i==n+1
        D(i,i)=4
        D(i,i-1)=-1
    else
        D(i,i)=4
        D(i,i+1)=-1
        D(i,i-1)=-1
    end
end
disp("Coefficient matrix : ",D)
order=(n+1)*(m+1)
Identity=eye(n+1,n+1)
I=-Identity 
disp(I)
A =zeros (order,order)//coefficient matrix
for i=1:n+1:order//for calculating coefficient matrix 
    for j=1:n+1:order
        if i==j
            A(i:i+n,j:j+n)=D
        elseif abs(i-j)==n+1
            A(i:i+n,j:j+n)=I
        else
            A(i:i+n,j:j+n)=zeros(n+1,n+1)
        end
    end
end
disp("Coefficient matrix : ",A)
//matrix of B
B=zeros(order,3)
//FC=zeros(order,1)
for j=1:m+1
    for i=1:n+1
        FC(j,i)=-(h^2)*r(x(j),y(i))
    end
end
disp(FC)
FC=matrix(FC,order,1)
disp("First column of B matrix : ",FC)
SC=zeros(order,1)
j=1
for i=1:n+1
    SC(i,1)=bottom(x(i),y(j))
end
//disp("Second column of B matrix : ",SC)
k=1
for i=order-(n+1)+1:order
    SC(i,1)=top(x(k),y(m+1))
    k=k+1
end
disp("Second column of B matrix : ",SC)
TC=zeros(order,1)
k=1
for i=1:(n+1):order
    TC(i,1)=left(x(1),y(k))
    k=k+1
end
k=1
for i=(n+1):(n+1):order
    TC(i,1)=right(x(n+1),y(k))
    k=k+1
end
disp("Third column of B matrix : ",TC)
B=FC+SC+TC
disp("B matrix : ",B)
sol=inv(A)*B
disp("Solution of PDE : ",sol)
L=matrix(sol,n+1,m+1)
disp("Solution : ",L)
plot3d(x,y,L)
//exact solution 
for k=1:order
    exact(k)=y/(((1+x)^2)+(y^2))
end
M=matrix(exact,n+1,m+1)
disp("Exact Solution : ",M)
plot3d(x,y,M)

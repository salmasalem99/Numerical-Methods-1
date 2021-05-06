% Author - Ambarish Prashant Chandurkar
%The Newton Raphson Method


function x = NewtonRaphson(func,es,maxit)
syms x;
tic;
ddx_func=diff(func,x); %The Derivative of the Function
ddx_func = matlabFunction(ddx_func);
LS = {'Initial Approximation: '};
J = inputdlg(LS,'Data:  ',1,{''});
xr(1) = str2double(J(1)); 
actual = fzero(func,xr(1));


for i=1:maxit
    
    f(i) = feval(func,xr(i)); %Calculating the value of function at x0
    f_der(i) = feval(ddx_func,xr(i));%Calculating the value of function derivative at x0
    if(f_der(i) == 0)
        error("Division by Zero..Please try again with another guess");
    end
    xr(i+1)= xr(i)-(f(i)/f_der(i)); % The Formula
    
    ea(i)= (abs((xr(i+1)-xr(i)))/xr(i+1))*100;
    
    if (abs(ea(i)) <es) %checking the amount of error at each iteration
        disp('Converged');
        break
    end
    
end
time = toc;
n=length(xr);
k=1:n-1;
root = double(xr(end));
ea = hpf(ea, 10);
xr = hpf(xr,10);
f = hpf(f, 10);
f_der = hpf(f_der, 10);
ea =arrayfun(@num2str,ea,'un',0);
xr =arrayfun(@num2str,xr,'un',0);
f =arrayfun(@num2str,f,'un',0);
f_der =arrayfun(@num2str,f_der,'un',0);
fig = uifigure('Position', [100 100 752 250]);
t = uitable('Parent', fig, 'Position', [25 50 700 200]);
t.ColumnName = {'Step',"X(i)", "F(Xi)", "F'(Xi)", "X(i+1)", "Error%"};
t.Data = table(k',xr(1:n-1)',f', f_der', xr(2:n)' ,ea');
theoretical = root - actual;
str = sprintf("Time Elapsed: " + time + "\nActual root value: " + actual + "\nError: " + theoretical);
msgbox(str);
% out = [k' x(1:n-1)' f(1:n-1)' f_der(1:n-1)'];
% disp(' ************NewtonRaphson**************')
% disp('step      x      f(x)     f''(x)')
% disp(vpa(out,5));



end
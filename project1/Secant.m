function root = Secant(func,es,maxit)
syms x;
LS = {'first guess: ', 'second guess:  '};
J = inputdlg(LS,'Data:  ',1,{'',''});
xr(1) = double(str2double(J(1)));
xr(2) = double(str2double(J(2)));
actual = fzero(func,xr(2));
tic;
for i = 3:1:maxit+2
    f(i-2) = double(feval(func, xr(i-2)));
    f(i-1) = double(feval(func, xr(i-1)));
    xr(i) = double(xr(i-1) - (f(i-1)*(xr(i-1) - xr(i-2)))/(f(i-1) - f(i-2)));
    ea(i-2) = double((abs(xr(i) - xr(i-1))/xr(i)))*100;
    if( abs(ea(i-2)) < es)
        root = xr(i);
        break;
    end
end
time = toc;
n=length(xr);
k=1:n-2;
xr = double(xr);
root = double(xr(end));
xr = hpf(xr, 10);
f = hpf(f, 10);
ea = hpf(ea,10);
ea = arrayfun(@num2str,ea,'un',0);
f = arrayfun(@num2str,f,'un',0);
xr =arrayfun(@num2str,xr,'un',0);
fig = uifigure('Position', [100 100 752 250]);
t = uitable('Parent', fig, 'Position', [25 50 700 200]);
t.ColumnName = {'Step',"X(i-1)", "X(i)", "F(X(i-1))", "F(X(i))", "X(i+1)", "Error%"};
t.Data = table(k',xr(1:n-2)',xr(2:n-1)',f(1:n-2)',f(2:n-1)',xr(3:n)' ,ea(1:n-2)');
theoretical = root - actual;
str = sprintf("Time Elapsed: " + time + "\nActual root value: " + actual + "\nError: " + theoretical);
msgbox(str);
% out = [k' x(1:n-2)' x(2:n-1)' f(1:n-2)' f(2:n-1)' x(3:n)'];
% disp(' ************Secant**************')
% disp('step      x(i-1)      x(i)      f(x)     f(x-1)      x(i+1)')
% disp(vpa(out,5));
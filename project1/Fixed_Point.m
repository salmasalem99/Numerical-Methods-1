function root = Fixed_Point(func,es,maxit)
LS = {'LowerBound: ', 'UpperBound:  ','Starting Point: '};
J = inputdlg(LS,'Data:  ',1,{'','',''});
a = str2double(J(1));
b = str2double(J(2));
x(1) = str2double(J(3));
tic
if(x(1) < a || x(1) > b)
    disp('The starting point does not lie in the specified interval');
    return;
end
for i = 2:1:maxit+1
    x(i) = feval(func,x(i-1));
    if(x(i) < a || x(i) > b)
        disp('Diverges away from given interval');
        break;
    end
    ea(i-1) = hpf(((abs(x(i)-x(i-1)))/x(i)) * 100, 10);
    if( abs(ea(i-1)) < es)
        break;
    end
end
time = toc;
root = double(x(end));
n=length(x);
k=1:n-1;
x = hpf(x,10);
ea =arrayfun(@num2str,ea,'un',0);
x =arrayfun(@num2str,x,'un',0);
ea = ['-' ea];
f = uifigure('Position', [100 100 752 250]);
t = uitable('Parent', f, 'Position', [25 50 700 200]);
t.ColumnName = {'Step','X(i)','g(x(i))', 'Error %'};
t.Data = table(k',x(1:n-1)',x(2:n)', ea(1:n-1)');
str = sprintf("Time Elapsed: " + time);
msgbox(str);
% disp(' ************Fixed Point**************')
% disp('step                 x(i)                   x(i+1)')
% disp(vpa(out,5));
end
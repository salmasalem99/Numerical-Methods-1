% Find root near xl using the false position method.


function root = false_position(func,es,maxit)

LS = {'Xlower: ', 'Xupper:  '};
J = inputdlg(LS,'Data:  ',1,{'',''});
xl = str2double(J(1));
xu = str2double(J(2));
actual = fzero(func,[xl xu]);
a(1) = xl;
b(1) = xu;
tic;
ya(1) = feval(func,a(1));
yb(1)= feval(func,b(1));

if ya(1) * yb(1) > 0.0
    disp('Function has same sign at end points')
end

for i = 1:maxit
    x(i) = hpf((a(i)*yb(i) - b(i)*ya(i))/(yb(i)-ya(i)), 10);
    y(i) = hpf(feval(func,x(i)), 10);
    if y(i) == 0.0
        disp('exact zero found');
        break;
    elseif y(i) * ya(i) < 0
        a(i+1) = a(i);
        ya(i+1) = ya(i);
        b(i+1) = x(i);
        yb(i+1) = y(i);
    else
        a(i+1) = x(i);
        ya(i+1) = y(i);
        b(i+1) = b(i);
        yb(i+1) = yb(i);
    end
    
    if(i > 1)
    ea(i-1) = hpf(abs((x(i) - x(i-1))/x(i) * 100), 10);
     if (abs(ea(i-1)) < es)
        disp('False Position method has converged');
        break
     end
    end
    iter = i;
end

if (iter >= maxit)
    disp('zero not found to desired tolerance');
end
time = toc;
root= double(x(end));
n=length(x);
k=1:n;
ea = hpf(ea, 10);
a = hpf(a, 10);
b = hpf(b, 10);
ea =arrayfun(@num2str,ea,'un',0);
x =arrayfun(@num2str,x,'un',0);
y =arrayfun(@num2str,y,'un',0);
a =arrayfun(@num2str,a,'un',0);
b =arrayfun(@num2str,b,'un',0);
ea = ["-" ea];
f = uifigure('Position', [100 100 752 250]);
t = uitable('Parent', f, 'Position', [25 50 700 200]);
t.ColumnName = {"Step","X-Lower","X-Upper","X-Root", "F(Xr)", "Error %"};
t.Data = table(k',a(1:n)',b(1:n)',x',y(1:n)', ea');
theoretical = root - actual;
str = sprintf("Time Elapsed: " + time + "\nActual root value: " + actual + "\nError: " + theoretical);
msgbox(str);
% disp(' ************FALSE POSITION**************')
% disp('      step      xl        xu        xr        f(xr) ' )
% disp(out)

end
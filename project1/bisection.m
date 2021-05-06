% Bisection Method



function xr = bisection(func,es,maxit)
%DefaultNumberOfDigits 100 5
LS = {'Xlower: ', 'Xupper:  '};
J = inputdlg(LS,'Data:  ',1,{'',''});
xl(1) = str2double(J(1));
xu(1) = str2double(J(2));
actual = fzero(func,[xl(1) xu(1)]);
tic;
if(feval(func,xl) * feval(func,xu) >0) % if guesses do not bracket, exit
    disp('no bracket');
    return
end

for i=1:1:maxit
    xr(i)=hpf((xu(i)+xl(i))/2, 10); % compute the midpoint xr
    test= feval(func,xl(i)) * feval(func,xr(i)); % compute f(xl)*f(xr)
     
    if(test < 0)
        xu(i+1)= xr(i);
        xl(i+1) = xl(i);
    else
        xl(i+1)= xr(i);
        xu(i+1)= xu(i);
    end
    
    if(i > 1)
    ea(i-1) = hpf(abs((xr(i) - xr(i-1))/xr(i) * 100), 10);
     if (abs(ea(i-1)) < es)
        disp('Bisection method has converged');
        break
     end
    end
     
end
time = toc;
root = double(xr(end));
n=length(xr);
k=1:n;
xl = hpf(xl, 10);
xl =arrayfun(@num2str,xl,'un',0);
xu = hpf(xu, 10);
xu =arrayfun(@num2str,xu,'un',0);
xr =arrayfun(@num2str,xr,'un',0);
ea =arrayfun(@num2str,ea,'un',0);
ea = ['-' ea];
f = uifigure('Position', [100 100 752 250]);
t = uitable('Parent', f, 'Position', [25 50 700 200]);
t.ColumnName = {'Step','X-Lower','X-Upper','X-Root', 'Error' };
t.Data = table(k', xl(1:n)', xu(1:n)', xr', ea');
theoretical = root - actual;
str = sprintf('Time Elapsed: ' + time + '\nActual root value: ' + actual + '\nError: ' + theoretical);
msgbox(str);
%writetable(t,'./tables.csv',"VariableNames",{"Steps","X-Lower","X-Upper","X-Root"});
% out=[k' xl(1:n)' xu(1:n)' xr(1:n)'];
% disp(' *********BISECTION***************')
% disp('     step      xl        xu        xr')
% disp(out)
end

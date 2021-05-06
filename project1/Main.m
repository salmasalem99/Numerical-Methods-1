% Numerical Analysis
%Project 1
%Behavior of numerical methods for root finding


    

CreateStruct.Interpreter = 'tex';
CreateStruct.WindowStyle = 'modal';
str = sprintf('Please read the upcoming instructions carefully:\n*use "x" as your variable\n\n*use . ');
str2 = sprintf( ' to represent powers\n\n*use exp() to represent an exponentioal function\n\n*use sin() and cos() to represent trigonometric function\n');
uiwait(msgbox('\fontsize{12} '+str + '\wedge' + str2,'Welcome',CreateStruct));
k = menu('','Input function as text','Read from file');
switch(k)
    case 1
        LS = {'Function: ', 'Tolerance:  ', 'Maximum number of iterations'};
        J = inputdlg(LS,'Data:  ',1,{'','0.00001','50'});
        scanned_eq = J{1};
        Es = str2double(J(2));
        MaxItr = str2double(J(3));
    case 2
        fileID = fopen('input.txt','r');
        scanned_eq = fscanf(fileID,'%s');
        fclose(fileID);
        LS = {'Tolerance:  ', 'Maximum number of iterations'};
        J = inputdlg(LS,'Data:  ',1,{'0.00001','50'});
        Es = str2double(J(1));
        MaxItr = str2double(J(2));
end
Es = 0.5*10^(2-tolerance(Es));
syms x;
scanned_eq = strcat('@(x)',scanned_eq);
eqn = str2func(scanned_eq);
k = menu('Choose a method','Bisection','FalsePosition','FixedPoint','Newton-Raphson','Secant');
switch(k)
    case 1
        bisection(eqn,Es,MaxItr);
    case 2
        false_position(eqn,Es,MaxItr);
    case 3
        Fixed_Point(eqn,Es,MaxItr);
    case 4
        NewtonRaphson(eqn,Es,MaxItr);
    case 5
        Secant(eqn,Es,MaxItr);
end

function sigfig = tolerance(error)
sigfig = 0;
while(error~=1)
    error = error*10;
    sigfig = sigfig + 1;
end
end
 
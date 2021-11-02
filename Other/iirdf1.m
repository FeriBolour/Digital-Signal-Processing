function y_n = iirdf1(f_n,B,A)
persistent f_register y_register Bx Ax N
%
% The following is initialization, and is executed once
%
 if (ischar(f_n) && strcmp(f_n,'initial'))
    N = length(A);
    Ax=A;
    Bx=B;
    f_register = zeros(1,N);
    y_register = zeros(1,N);
    y_n=0;
else
    % Filtering: (Note that a Direct Form I filter needs two shift registers.)
    x=0;y=0;
    for J = N:-1:2
        y_register(J) = y_register(J-1); % Move along the shift register
        f_register(J) = f_register(J-1);
        y=y- Ax(J)*y_register(J);
        x=x+ Bx(J)*f_register(J);
    end
    x=x+ Bx(1)*f_n;
    y_n=y+x;
    f_register(1) = f_n;
    y_register(1) = y_n;
end
end
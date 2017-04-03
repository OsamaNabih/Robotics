function [q1] = Inverse(l1,l2,l3,a,b,theita,q1max,q1min,q2max,q2min,q3max,q3min)
if (l1 > 0 && l2 > 0 && l3 > 0) 
    a1 = a - l3*cosd(theita);
    b1 = b - l3*sind(theita);
    r = sqrt((a1^2+b1^2));
    phi = [acosd((l1^2+r^2-l2^2)/(2*l1*r)), -acosd((l1^2+r^2-l2^2)/(2*l1*r))];
    q1 = atand(b1/a1)-phi;
    %Fixing the quadrant issues with the tan inverse functions
 
    if ((b1 > 0 && a1 < 0) || (b1 < 0 && a1 < 0))
        q1 = q1 + 180;
    end
    if (b1 < 0 && a1 > 0)
        q1 = q1 + 360;
    end
 
    Rsin=r*sind(phi);
    Rcos=(r*cosd(phi))-l1;
    q2 = atand(Rsin./Rcos);
    %1
    if ( (Rsin(1) > 0 && Rcos(1) < 0) || (Rsin(1) < 0 && Rcos(1) < 0 ) )
        q2(1) = q2(1) + 180;
    end
    if (Rsin(2) < 0 && Rcos(2) > 0)
        q2(1) = q2(1) + 360;
    end
    %2
    if ( (Rsin(2) > 0 && Rcos(2) < 0) || (Rsin(2) < 0 && Rcos(2) < 0 ) )
        q2(2) = q2(2) + 180;
    end
    if (Rsin(2) < 0 && Rcos(2) > 0)
        q2(2) = q2(2) + 360;
    end

    q3 = theita-q1-q2;
       hold on
if (isreal(q1(1)) && isreal(q2(1)) && isreal(q3(1)))
%There exists a solution for alpha 1
    if (q1(1) <= q1max && q1(1) >= q1min && q2(1) <= q2max && q2(1) >= q2min && q3(1) <= q3max && q3(1) >= q3min)
    x = [0 l1*cosd(q1(1)) l1*cosd(q1(1))+l2*cosd(q1(1)+q2(1)) a];
    y = [0 l1*sind(q1(1)) l1*sind(q1(1))+l2*sind(q1(1)+q2(1)) b];
    plot(x,y,'k')
    end
    %Checking if the real solution is within permitted ranges
else
    %No solution
end
if (isreal(q1(2)) && isreal(q2(2)) && isreal(q3(2)))
%%There exists a solution for alpha 1
    if (q1(2) <= q1max && q1(2) >= q1min && q2(2) <= q2max && q2(2) >= q2min && q3(2) <= q3max && q3(2) >= q3min)
      x = [0 l1*cosd(q1(2)) l1*cosd(q1(2))+l2*cosd(q1(2)+q2(2)) a];
      y = [0 l1*sind(q1(2)) l1*sind(q1(2))+l2*sind(q1(2)+q2(2)) b];
      plot(x,y,'k')
      
    end
    %Checking if the real solution is within permitted ranges
else
    %No solution
end
else
    msgbox('Lengths Values must be +ve', 'Error','error');
    axis square;
end
q1 = [q1 q2 q3];

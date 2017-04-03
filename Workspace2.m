function [] = Workspace2(l1,l2,l3,q1max,q1min,q2max,q2min,q3max,q3min)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

hold off
if (l1 > 0 && l2 > 0 && l3 > 0)
%In case the minimum is larger than the maximum, the users wants the reflex
%angle, this is solved by adding 360 to the max, passing the new values to
%linspace and then subtracting any value above 360
%FOR EXAMPLE:
%Say q1min is 90 and q1 max is 20, if we write linspace(q1min,q1max), the
%returned vector will have values between 20 and 90, not from 90 passing
%through 180 then 270 then 20, which is what the user wants
%So by incrementing 20 by 360, we can write linspace(90,380), hence
%obtaining values between 90 and 380, by subtracting 360 from any value
%higher than 360 inside the vector, we obtain a vector of values from 90
%degrees then going anti clockwise till 20
    if (q1min > q1max)
        q1max = 360+q1max;
    end
     if (q2min > q2max)
        q2max = 360+q2max;
     end
     if (q3min > q3max)
        q3max = 360+q3max;
     end
    %Function linspace returns a vector of 100 evenly divided numbers
    %between its two parametres
    q1 = linspace(q1min,q1max,150);
    q2 = linspace(q2min,q2max,150);
    q3 = linspace(q3min,q3max,150);

    %subtracting 360 of any element of value > 360
    for m = 1:1:150
        if (q1(m) > 360)
            q1(m) = q1(m) - 360;
        end
        if (q2(m) > 360)
            q2(m) = q2(m) - 360;
        end
        if (q3(m) > 360)
            q3(m) = q3(m) - 360;
        end
    end

    %Iterating through the vectors obtained from linspace in order to cover
    %the entire range and then plotting each point
    for i = 1:1:150
        for j = 1:1:150
        %Note: q3 is a vector, therefore a and b are both vectors, matlab
        %automatically does this line for all values inside vector q3,
        %hence we don't need to make a third loop
        a=l1*cosd(q1(i))+l2*cosd(q1(i)+q2(j))+l3*cosd(q1(i)+q2(j)+q3);
        b=l1*sind(q1(i))+l2*sind(q1(i)+q2(j))+l3*sind(q1(i)+q2(j)+q3);
        plot(a,b,'.')
        hold on;
        end
    end
else
    msgbox('Lengths Values must be +ve', 'Error','error');
end
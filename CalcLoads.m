function [Q] = CalcLoads(l1,l2,l3,Fx,Fy,M,q1max,q1min,q2max,q2min,q3max,q3min)
%P is the 3x1 vector of external loads, Q is the maximum load on each joint
if (l1 > 0 && l2 > 0 && l3 > 0) 
    P = [Fx;Fy;M];
    if (q1min > q1max)
        q1max = 360+q1max;
    end
     if (q2min > q2max)
        q2max = 360+q2max;
     end
     if (q3min > q3max)
        q3max = 360+q3max;
     end
    q1 = linspace(q1max,q1min);
    q2 = linspace(q2max,q2min);
    q3 = linspace(q3max,q3min);
    Q = zeros(3,1);
    
    
    for m = 1:1:100
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
    for i = 1:1:100
        for j = 1:1:100
            for k = 1:1:100
                %Hardcoding the jacobian matrix, calculating the loads with
                %every possible value of q1 q2 q3, if this value is bigger
                %than the current value of the load in Q, replace the old
                %load with the new larger one
                J11=-(l1*sind(q1(i))+l2*sind(q1(i)+q2(j))+l3*sind(q1(i)+q2(j)+q3(k)));
                J21=l1*cosd(q1(i))+l2*cosd(q1(i)+q2(j))+l3*cosd(q1(i)+q2(j)+q3(k));
                J12=-l2*sind(q1(i)+q2(j))-l3*sind(q1(i)+q2(j)+q3(k));
                J22=l2*cosd(q1(i)+q2(j))+l3*cosd(q1(i)+q2(j)+q3(k));
                J13=-l3*sind(q1(i)+q2(j)+q3(k));
                J23=l3*cosd(q1(i)+q2(j)+q3(k));
                J31=1;
                J32=1;
                J33=1;
                J=[J11 J12 J13;J21 J22 J23; J31 J32 J33];
                Loads = -(J')*P;
                for o = 1:1:3
                    if (Loads(o) > Q(o))
                        Q(o) = Loads(o);
                    end
                end
            end
        end
    end
else
    msgbox('Lengths Values must be +ve', 'Error','error');
end
end
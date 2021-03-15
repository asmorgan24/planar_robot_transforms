function draw_robot(symb_vars, in_vals, T)
    xoffset = 0;
    yoffset = 0;

    %Draw base frame
    figure(1)
    hold on
    start = -1.5; ending = 1.5;
    l = line([start,ending],[0,0], 'Color', 'k');
    l.LineWidth = 3;
    dist_inc = abs(ending - start)/10;
    for i =0:1:10
        line([start+dist_inc*i, start+dist_inc*i-(dist_inc/1.5)],[0, 0-dist_inc], 'Color','k','Linewidth', 3  );  
    end


    %Calculate serial link robot kinematics
    assert(length(symb_vars)==length(in_vals))
    x_line = [0]; y_line = [0];

    for i=1:1:length(T)
        m = subs(T{i}, symb_vars, in_vals);
        x_line = [x_line,m(1,3)]; y_line = [y_line,m(2,3)];
    end
    x_line = double(x_line+xoffset); y_line = double(y_line+yoffset);
    
    %Plot
    l = line(x_line, y_line, 'Color', 'k');
    l.LineWidth = 6;
    for i=1:1:length(x_line)
       circle(x_line(i),y_line(i),0.12,'w','k', 3) 
    end
    
    axis equal
    axis off


end

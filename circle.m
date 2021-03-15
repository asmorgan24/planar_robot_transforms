function h = circle(x,y,r,MarkerFaceColor,MarkerEdgeColor,MarkerEdgeWidth)
    hold on
    c = [x y];
    pos = [c-r 2*r 2*r];
    r = rectangle('Position',pos,'Curvature',[1 1], ...
        'FaceColor', MarkerFaceColor, 'Edgecolor',MarkerEdgeColor,'LineWidth', MarkerEdgeWidth);
    hold off
end
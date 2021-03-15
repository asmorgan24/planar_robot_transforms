function save_fig(filename, DPI, file_type)
    if ~exist('DPI', 'var')
        DPI = 600;
    end
    if ~exist('file_type', 'var')
        file_type = 'png';
    end
    
    if strcmp(file_type, 'png')
        print(sprintf('-r%i',DPI), '-dpng', sprintf('%s.png', filename));
    elseif strcmp(file_type, 'tiff')
        print(sprintf('-r%i',DPI), '-dtiff', sprintf('%s.tif', filename));
    elseif strcmp(file_type, 'eps')
        print(sprintf('-r%i',DPI), '-deps', sprintf('%s.eps', filename));
    elseif strcmp(file_type, 'jpeg')
        print(sprintf('-r%i',DPI), '-djpeg', sprintf('%s.jpeg', filename));
	elseif strcmp(file_type, 'ai')
        print(sprintf('-r%i',DPI), '-dill', sprintf('%s.ai', filename));
    elseif strcmp(file_type, 'eps')
        print(sprintf('-r%i',DPI), '-depsc', sprintf('%s.eps', filename));
    else
        disp('invalid file type specified')
    end

end
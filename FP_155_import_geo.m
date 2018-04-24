function [ read_geo, mesh_size ] = FP_155_import_geo()
% Function to read excel file for reactor input
    % excel_file is the Excel file to be read with reactor geometry
    % mesh_geo_size is the size of the mesh and geometry
        % input will be a number indicating what each geometry cell size
            % 1   will indicate each cell is 1.0 cm
            % 0.5 will indicate each cell is 0.5 cm
            % 0.1 will indicate each cell is 0.1 cm

excel_file = uigetfile({'*.xlsx';'*.xlsm';'*.xltx';'*.xltm'},'Choose Input File'); 
read_geo = xlsread(excel_file);

prompt = {'Enter mesh size (cm)'};
title = 'Mesh Size Input';
dims = [1 20];
answer = inputdlg(prompt, title, dims);

mesh_size = str2double(answer(1));

[N_Rows, M_Cols] = size(read_geo); 
    if N_Rows ~= M_Cols
        error('Input must be square geometry.')
    end
        
end


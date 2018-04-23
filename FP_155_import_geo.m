function [ read_geo, m_size ] = FP_155_import_geo( excel_file , mesh_geo_size )
% Function to read excel file for reactor input
    % excel_file is the Excel file to be read with reactor geometry
    % mesh_geo_size is the size of the mesh and geometry
        % input will be a number indicating what each geometry cell size
            % 1   will indicate each cell is 1.0 cm
            % 0.5 will indicate each cell is 0.5 cm
            % 0.1 will indicate each cell is 0.1 cm

read_geo = xlsread(excel_file);
m_size = mesh_geo_size;

[N_Rows, M_Cols] = size(read_geo); 
    if N_Rows ~= M_Cols
        error('Input must be square geometry.')
    end
        
end


function pozymiai = pozymiai_raidems_atpazinti(pavadinimas, pvz_eiluciu_sk)
%%  pozymiai = pozymiai_raidems_atpazinti(pavadinimas, pvz_eiluciu_sk)
% Features = pozymiai_raidems_atpazinti(image_file_name, Number_of_symbols_lines)
% taikymo pavyzdys:
% pozymiai = pozymiai_raidems_atpazinti('test_data.png', 8); 
% example of function use:
% Feaures = pozymiai_raidems_atpazinti('test_data.png', 8);
%%
% Read image with written symbols
V = imread(pavadinimas); % returns RGB pixels values
figure(12), imshow(V)

%% Perform segmentation of the symbols and write into cell variable 
% RGB image is converted to grayscale
V_pustonis = rgb2gray(V);

% A threshold value is calculated for binary image conversion
slenkstis = graythresh(V_pustonis);

% A grayscale image is converte to binary image
V_dvejetainis = im2bw(V_pustonis,slenkstis);

% Show the resulting image
figure(1), imshow(V_dvejetainis)

% Search for the contours of each object and note them in the image
V_konturais = edge(uint8(V_dvejetainis));

% Show the resulting image
figure(2),imshow(V_konturais)

% Fill the contours of the objects
se = strel('square',7); % creates a square structuring element whose width is 7 pixels.
V_uzpildyti = imdilate(V_konturais, se); 
% Dilating an image is a morphological operation used in image processing 
% to enhance or enlarge the shapes or regions in the image.
% Grayscale Image:
% 1. In a grayscale image, each pixel has a numerical value representing the intensity or brightness.
% 2. Dilating a grayscale image involves placing the structuring element at each pixel location and replacing the 
% pixel value with the maximum value within the neighborhood defined by the structuring element.
% 3. The result is an image where the brighter regions are expanded based on the structuring element's shape.

% Show the result
figure(3),imshow(V_uzpildyti)

% Fill the objects holes
V_vientisi= imfill(V_uzpildyti,'holes');

% Show the result
figure(4),imshow(V_vientisi)

% Set labels to binary image objects
[O_suzymeti Skaicius] = bwlabel(V_vientisi);
% Label connected components (pixel clusters) in 2-D binary image
% Skaicius - number of labeled components
% O_suzymeti - binary image with labeled pixel clusters

% Calculate features for each binary object from the image
O_pozymiai = regionprops(O_suzymeti);

% Cind/read the bounding box (boundary coordinates) of each binary object from the image
O_ribos = [O_pozymiai.BoundingBox];

% Change the sequence of boundary coordinates, describing the bounding box,
% of each object.
O_ribos = reshape(O_ribos,[4 Skaicius]); % reshaping labeled image matrix

% The mass center coordinates of each object
O_centras = [O_pozymiai.Centroid];

% Re-group center coordinate values of each object
O_centras = reshape(O_centras,[2 Skaicius]);
O_centras = O_centras';

% Set the label/number for each object in the image
O_centras(:,3) = 1:Skaicius;

% Arrange objects according to the column number (x axis)
O_centras = sortrows(O_centras,2);
% Sorts the rows of a matrix in ascending order based on the elements in the first column.

% Sort accordign to the number of rows (y axis) and number of symbols in
% the row (y axis)
raidziu_sk = Skaicius/pvz_eiluciu_sk;
for k = 1:pvz_eiluciu_sk
    O_centras((k-1)*raidziu_sk+1:k*raidziu_sk,:) = ...
        sortrows(O_centras((k-1)*raidziu_sk+1:k*raidziu_sk,:),3);
end

% Cut the symbol from initial image according to the bounding box estimated in binary image
for k = 1:Skaicius
    objektai{k} = imcrop(V_dvejetainis,O_ribos(:,O_centras(k,3)));
end

% Show one of the object's image
figure(5),
for k = 1:Skaicius
   subplot(pvz_eiluciu_sk,raidziu_sk,k), imshow(objektai{k})
end

% image segments are cutt off (without the backgruond) using boundary box
% coordinates
for k = 1:Skaicius % Skaicius = 88, jei yra 88 raidës
    V_fragmentas = objektai{k};

    % estimate the size of each object
    [aukstis, plotis] = size(V_fragmentas);
    
    % 1. Eliminate white columns
    % Calculate selected column sum of pixel values
    stulpeliu_sumos = sum(V_fragmentas,1);
    % Delete column if it's sum of pixel is eaqual to the number of pixels
    % in te column (it means that each column pixel is white (binary value 1))
    V_fragmentas(:,stulpeliu_sumos == aukstis) = [];
    % Re-caculate objct size with removed whte columns
    [aukstis, plotis] = size(V_fragmentas);
    % 2. Eliminate white rows
    % Calculate selected row sum of pixel values
    eiluciu_sumos = sum(V_fragmentas,2);
    % Delete column if it's sum of pixel is eaqual to the number of pixels
    % in the row (it means that each column pixel is white (binary value 1))
    V_fragmentas(eiluciu_sumos == plotis,:) = [];
    objektai{k} = V_fragmentas;% overwrite old (not cut off) image with the new one (cut off) image
end

% Show the each object
figure(6),
for k = 1:Skaicius
   subplot(pvz_eiluciu_sk,raidziu_sk,k), imshow(objektai{k})
end

%% Make all objects of the same size 70x50
for k=1:Skaicius
    V_fragmentas=objektai{k};
    V_fragmentas_7050=imresize(V_fragmentas,[70,50]);

    % Divide each object into 10x10 size segments
    for m=1:7
        for n=1:5
            % Calculate an average intensity for each 10x10 segment
            Vid_sviesumas_eilutese=sum(V_fragmentas_7050((m*10-9:m*10),(n*10-9:n*10)));
            Vid_sviesumas((m-1)*5+n)=sum(Vid_sviesumas_eilutese);
        end
    end
    
    % Perform normalization of intensity values from [0, 100] to [0, 1]
    Vid_sviesumas = ((100-Vid_sviesumas)/100);

    % Transform features from row-vector into column-vector
    Vid_sviesumas = Vid_sviesumas(:);

    % Save all object's fratures into single variable
    pozymiai{k} = Vid_sviesumas;
end

%% Read matrix from the txt log files
close all; clc; clear
code_name = "SHC";
attempt = "2";
A = readmatrix("new_data/adc_"+code_name+attempt+".txt");
%Remove unnecessary columns
B = A(:,17:length(A));

% Plot all full-length echo-readings 
for index = 1:100
    S = B(index,:);
    % Normalizing
    S = S./max(max(S),abs(min(S)));
    S = S-mean(S);
    t = 1:length(S);
    % Plotting
    plot(t,S)
    title(index)
    axis([1 length(S) -1 1]); xlabel('time '); ylabel('normalized amplitude')
    grid on
    hold on
    drawnow
end

%% Choose all trimmed echo-readings and create spectrograms respectively
 for index = 1:100
    S = B(index,1:length(B));
    % Define time vector
    t = 1:length(S);
    % Normalizing
    S = S./max(max(S),abs(min(S)));
    S = S-mean(S);   
    % Gabor Transform
    L = 40; 
    n = length(S);
    k = (2*pi/L)*[0:n/2-1 -n/2:-1]; ks = fftshift(k);
    Sgt_spec = [];
    tslide = 0:100:n; % Moving Gabor filter every 100 samples !
    for j = 1:length(tslide)
        g = exp(-5*1e-5*(t-tslide(j)).^2); %Gabor filter function
        Sg = g.*S;
        Sgt = fft(Sg);
        Sgt_spec=[Sgt_spec; abs(fftshift(Sgt))];
    end
    Sgt_spec=Sgt_spec';% transpose the spectrogram for better representation
    % Export spectrograms
    figure
    pcolor(tslide,ks,Sgt_spec)
    shading interp
    set(gca,'Ylim',[40 70])
    colormap gray
    set(gca, 'Visible', 'off');    
    exportgraphics(gca,"new_training/"+code_name+"_"+attempt+"_"+index+".png"...
                   ,'Resolution',100);
    close
    image = imread("new_training/"+code_name+"_"+attempt+"_"+index+".png");
    new_image = rgb2gray(image);
    imwrite(new_image,"new_training/"+code_name+"_"+attempt+"_"+index+".png");
 end
close all
beep
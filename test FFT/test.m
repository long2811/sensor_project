close all; clear; clc

%Init
offset = 17;
freq_range = 0:84;
freq_range = freq_range + offset;
total_sample = 200;

Empty = readmatrix('fft_160_20000_BEC_2.txt');
TR_Empty = Empty(:,freq_range);

subplot(1,2,1)
grid on
hold on
xlim([0 84])
for i = 1:total_sample
    stem(freq_range-offset,TR_Empty(i,:),'x','blue')
    drawnow
end

% yline(mean(std(TR_Empty(:,:),0,2)),'black')
% empty_std_m = mean(std(TR_Empty(:,:),0,2));
yline(mean(mean(TR_Empty(:,:),2)),'green','empty fft mean')
empty_m = mean(mean(TR_Empty(:,:),2));

Human = readmatrix('fft_160_20000_BHC.txt');
TR_Human = Human(:,freq_range);

subplot(1,2,2)
grid on
hold on
xlim([0 84])
for i = 1:total_sample
    stem(freq_range-offset,TR_Human(i,:),'red')
    drawnow
end

% yline(mean(std(TR_Human(:,:),0,2)),'black')
% human_std_m = mean(std(TR_Human(:,:),0,2));
yline(mean(mean(TR_Human(:,:),2)),'green','human fft mean')
human_m = mean(mean(TR_Human(:,:),2));

subplot(1,2,1)
yline((empty_m-human_m)/2+human_m,':','threshold')

subplot(1,2,2)
yline((empty_m-human_m)/2+human_m,':','threshold')

(empty_m-human_m)/2+human_m
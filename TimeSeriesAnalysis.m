%%% Code for time series data analysis %%% 
% data are event data with durations in minutes, red and green events

%% Load data
eventTable = readtable('D:/TimeSeriesEventData.xlsx');
% Create MATLAB datenumbers from the Excel dates
infmt = 'dd/MM/yyyy';
% assign column infos
dates = datetime(eventTable{:,1}, 'InputFormat',infmt);
redEvents = eventTable{:,2};
greenEvents = eventTable{:,3};

%% Count number of events and how many are missing
% red events
[row, column] = find(redEvents>0);
REs       = [row, column];
cNumREs = length(REs);
missingREs = (365 - cNumREs); % subtract the number of events from days of the year
fprintf('Number of days with red events: %d \n', cNumREs);

% green events
[row, column] = find(greenEvents>0);
GEs       = [row, column];
cNumGEs = length(GEs);
missingGEs = (365 - cNumGEs);
fprintf('Number of days with green events: %d \n', cNumGEs);

%% Analyse Mean, Maximum Events, and Change Points
% mean values of events
meanREs = mean(eventTable{:,2},"omitnan");
meanGEs = mean(eventTable{:,3},"omitnan");
fprintf('The mean duration of red is: %.2f minutes, \nThe mean duration of green is: %.2f minutes \n', meanREs, meanGEs);

% maximum events
maxREs = max(eventTable{:,2});
maxGEs = max(eventTable{:,3});

if maxREs > maxGEs
    fprintf('The biggest event was red with %.2f minutes \n', maxRES);
else
    fprintf('The biggest event was green with %.2f minutes \n', maxGEs);    
end

% change points
% TODO - need to explore this more - does this need filled data /continous
% data? .. 
% changeRE = ischange(eventTable{:,2}, 'variance');

%% Plot red and green events
figure('units','normalized','outerposition',[0 0 1 1]);
% Set the font size for the figure
font_size = 24;
set(0, 'DefaultAxesFontSize', font_size);
% Set the figure background to be white
set(gcf,'color','w');
hold on

p1 = plot(dates, redEvents, 'dm');
p2 = plot(dates, greenEvents, 'dg');

grid on
xlim([min(dates) max(dates)]);

title('Time Series of Red and Green Events')
xlabel('Date [DD/MM/YYYY]')
ylabel('Duration [minutes]')

legend('Red Events','Green Events')

%save image
% print('-dpng','-r300',...
%  'Events2021.png');

%% examine season subtests: find mean values of red and green events during the 4 seasons
% extract seasons by date
spring = (dates>='2021-01-01' & dates<='2021-03-31'); 
summer = (dates>='2021-04-01' & dates<='2021-06-30');
autumn = (dates>='2021-07-01' & dates<='2021-09-30');
winter = (dates>='2021-10-01' & dates<='2021-12-31');

% create array of seasons to iterate
seasons = ["spring", "summer", "autumn", "winter"]; % if you'd use ";" instead it's a 4x1 string

% create array for RE and GE for seasons

springREs = find(spring);
meanSpringREs = mean(springREs,"omitnan");

for i=1:length(seasons)
    % append mean values to those RE and GE seasons
    % need to extract i from array
    fprintf("hello %d \n", i);
end


% write this into a loop
% for the seasons > calc mean for RE and GEs > write this into arrays >
% plot as scatterplot with magenta and green labelling



%% Subset Test - April 2021 data
% find actually extracts events -- from here ToDo
April2021Dates = find(dates>='2021-04-01' & dates<='2021-04-30');
April2021RE = find(redEvents>='2021-04-01' & redEvents<='2021-04-30');
April2021GE = find(greenEvents>='2021-04-01' & greenEvents<='2021-04-30');

%% Plot red and green events in April 2021
figure('units','normalized','outerposition',[0 0 1 1]);
% Set the font size for the figure
font_size = 24;
set(0, 'DefaultAxesFontSize', font_size);
% Set the figure background to be white
set(gcf,'color','w');
hold on

p1 = plot(April2021Dates, April2021RE, 'dm');
p2 = plot(April2021Dates, April2021GE, 'dg');

grid on
xlim([min(April2021Dates) max(April2021Dates)]);

title('Time Series of Red and Green Events in April 2021')
xlabel('Date [DD/MM/YYYY]')
ylabel('Duration [minutes]')

legend('Red Events','Green Events')
%print('-dpng','-r300',...
%  '../EventsApril2021.png');

%% Examination of filling in missing data 
% how to check whether interpolation even makes sense if there aren't that
% many events? (e.g. 70 green events)

% Interpolate to 1-day
%xq = (min(dates):1:max(dates));
%interp = interp1(dates, redEvents, xq, 'spline');

%% Make a figure with Interpolated Data
% can actual datapoints be a different colour to the interpolated ones?

%% Smoothen Data
% https://uk.mathworks.com/help/signal/examples/signal-smoothing.html
% Median Filter:

% Gaussian Filter: 

% Savitzky-Golay filtering:
% https://uk.mathworks.com/help/signal/ref/sgolayfilt.html

%% Make a Figure with Smoothened Data

%% Seasonality Analysis
% does this make sense or would eg be average per quarter be enough?

%% Modelling Future Values Possible
% See: https://uk.mathworks.com/help/ident/examples/timeseries-prediction-and-forecasting-for-prognosis.html for a worked example.


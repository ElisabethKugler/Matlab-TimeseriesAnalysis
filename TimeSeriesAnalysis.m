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
annualEvents = figure('units','normalized','outerposition',[0 0 1 1]);
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

% save image
saveas(annualEvents, 'Events2021.png');


%% examine season subtests: find mean values of red and green events during the 4 seasons
% extract seasons by date
% Get the month numbers for dates
monthNum = month(dates(:,1)); 
spring = ismember(monthNum, [1:3]); 
summer = ismember(monthNum, [4:6]); 
autumn = ismember(monthNum, [7:9]); 
winter = ismember(monthNum, [10:12]); 

% create array of seasons to iterate
seasons = ["spring", "summer", "autumn", "winter"]; % if you'd use ";" instead it's a 4x1 string

%springREs = find(spring); % that needs to select spring
%meanSpringREs = mean(springREs,"omitnan");

seasonsMeanVal = [];
%A(i) = A(i) + ia_time(i) ;

for i=1:length(seasons)
    % append mean values to those RE and GE seasons
    % need to extract i from array
    meanVal = mean(redEvents(i, :));
    % seasonsMeanVal = seasonsMeanVal + meanVal;

%    A(i) = A(i) + ia_time(i);

    fprintf(" %d mean is %d \n", seaons(i), meanVal);
end


% write this into a loop
% for the seasons > calc mean for RE and GEs > write this into arrays >
% plot as scatterplot with magenta and green labelling


%% Subset Test - April 2021 data
% Logical index of rows in April
monthIdxApril = ismember(monthNum, [4]); 
% Extract your data for these months
% April2021Dates = find(dates>='2021-04-01' & dates<='2021-04-30'); %
% 91-120
April2021Dates = dates(monthIdxApril, :);
April2021RE = redEvents(monthIdxApril, :);
April2021GE = greenEvents(monthIdxApril, :);

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

% save image
saveas(annualEvents, 'EventsApril2021.png');


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


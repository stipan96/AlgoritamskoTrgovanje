def ichimoku_cloud(data):
    

    fig = plt.figure()
    first = plt.figure(figsize=(60,12.5))
    second = plt.figure(figsize=(60,12.5))
    ax = first.add_subplot(121)
    ax2 = second.add_subplot(122)
    

    period_high_9 = data['high'].rolling(9).max()
    period_low_9 = data['low'].rolling(9).min()
    data['conversion_line'] = (period_high_9 + period_low_9)/2 
    

    period_high_26 = data['high'].rolling(26).max()
    period_low_26 = data['high'].rolling(26).min()
    data['base_line'] = (period_high_26 + period_low_26)/2 
    data['lead_span_A'] = (data['conversion_line'] + data['base_line'])/2
    

    period_high_52 = data['high'].rolling(52).max()
    period_low_52 = data['low'].rolling(52).min()  
    data['lead_span_B'] = (period_high_52 + period_low_52)/2 
    data['lag'] = data['close'].shift(-26)
    

    graph = sns.lineplot(data = data, x = 'date', y = 'close', ax = ax, label = 'Close')
    sns.lineplot(data = data, x = 'date', y = 'lead_span_A', ax = ax, label = 'Senkou Span A', color = 'green')
    sns.lineplot(data = data, x = 'date', y = 'lead_span_B', ax = ax, label = 'Senkou Span B', color = 'red')
    graph.set_title("Ichimoku Cloud")
    
    
    ax.fill_between(data.date, data['lead_span_A'], data['lead_span_B'],
                    where=data['lead_span_A'] >= data['lead_span_B'], color='lightgreen')

    ax.fill_between(data.date, data['lead_span_A'], data['lead_span_B'],
                    where=data['lead_span_A'] < data['lead_span_B'], color='coral')
    
   
    bottom_plot = sns.lineplot(data = data, x = 'date', y = 'close', ax = ax2, label = 'Close', alpha = 0.5, color = 'blue')
    sns.lineplot(data = data, x = 'date', y = 'lag', ax =ax2, color = 'orange', label = 'Chikou Span')
    bottom_plot.set_title('Crossover Signals: Tenkan San, Kijun San, Chikou Span')


    buy = []
    sell = []
    flag = -1 
    
    for i in range(len(data['close'])):
        if data['conversion_line'][i] > data['base_line'][i]:
            if flag != 1:
                sell.append(np.nan)
                buy.append(data['close'][i])
                flag = 1
            else:
                sell.append(np.nan)
                buy.append(np.nan)
        elif data['conversion_line'][i] <= data['base_line'][i]:
            if flag != 0:
                sell.append(data['close'][i])
                buy.append(np.nan)
                flag = 0
            else:
                sell.append(np.nan)
                buy.append(np.nan)
        else:
            sell.append(np.nan)
            buy.append(np.nan)

    data['buy_sig'] = buy
    data['sell_sig'] = sell
    
   
    plt.scatter(data['date'], data['buy_sig'], marker = '^', color = 'green', alpha = 1)
    plt.scatter(data['date'], data['sell_sig'], marker = 'v', color = 'red', alpha = 1)
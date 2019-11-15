def process_fillna(df, column, value):
    df.loc[:, column].fillna(value, inplace=True)
    
def monthly_debt(df, debt_ratio_fill_value):
    df.loc[:,'MonthlyDebt']=df['DebtRatio']*df['MonthlyIncome']
    df.loc[df['MonthlyIncome'] == 0,'MonthlyDebt']=df.loc[df['MonthlyIncome'] == 0,'DebtRatio']
    df.loc[df['MonthlyIncome'] == 0,'DebtRatio']=debt_ratio_fill_value

def balanced_income(df):    
    income_positive = df['MonthlyIncome'] > df['MonthlyDebt']
    df.loc[income_positive,'BalancedIncome']= df.loc[income_positive,'MonthlyIncome'] - df.loc[income_positive,'MonthlyDebt']

def income_per_hm(df):
    df.loc[:,'IncomePerHouseholdMember']= df['BalancedIncome'] / (df['NumberOfDependents']+1)

def late_category(df):
    df.loc[:,'LateCategory']="L0"
    df.loc[df['NumberOfTimes90DaysLate'] == 98,'LateCategory']="L98"
    df.loc[df['NumberOfTimes90DaysLate'] == 96,'LateCategory']="L96"
    df.loc[(df['NumberOfTimes90DaysLate'] == 98) | (df['NumberOfTimes90DaysLate'] == 96),
              ['NumberOfTime30-59DaysPastDueNotWorse','NumberOfTime60-89DaysPastDueNotWorse','NumberOfTimes90DaysLate']]=None

def late_score(df, weight):
    df.loc[:,'LateScore']=weight[2]*df['NumberOfTimes90DaysLate']+weight[1]*df['NumberOfTime60-89DaysPastDueNotWorse']+weight[0]*df['NumberOfTime30-59DaysPastDueNotWorse']

def drop_columns(df, columns):
    for column in columns:
        df.drop(column, axis=1, inplace=True)
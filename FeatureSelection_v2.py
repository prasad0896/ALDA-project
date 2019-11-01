# To add a new cell, type '# %%'
# To add a new markdown cell, type '# %% [markdown]'

# %%
import numpy as np
import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegressionCV
from sklearn.model_selection import TimeSeriesSplit as tscv, train_test_split
from sklearn.metrics import accuracy_score as acc
from mlxtend.feature_selection import SequentialFeatureSelector as sfs


# %%
def result_to_numeric(x):
    if x=='W' or x=='w':
        return 1
    elif x=='L' or x=='l':
        return 0


# %%
clf = LogisticRegressionCV(cv= tscv(n_splits = 5), random_state=42, solver='liblinear')

# %% [markdown]
# ## Begin working with offensive stats from 1999

# %%
# Read data for dataset from '99 with offensive stats
df = pd.read_csv('completeFinalDatasetFrom99_Pruned.csv', sep=',')
df = df.drop(['Year','TeamA','TeamB'],axis=1)
df['WL'] = df['WL'].apply(result_to_numeric)
print(df.head())
print(df.columns)


# %%
# Train/test split
X_train, X_test, y_train, y_test = train_test_split(
    df.values[:,:-1],
    df.values[:,-1],
    test_size=0.30,
    random_state=42,
    shuffle=False)

y_train = y_train.astype('int')
y_test = y_test.astype('int')


# %%
sfs1 = sfs(clf,
           k_features='best',
           scoring='accuracy',
           verbose=2,
           forward=True,
           cv=tscv(n_splits = 5))

#Perform SFFS
sfs1 = sfs1.fit(X_train, y_train)


# %%
print("Best accuracy from sfs:", sfs1.k_score_)
print("Indices selected by sfs:", sfs1.k_feature_idx_)
print("List of selected indices:", df.columns[[x for x in (list(sfs1.k_feature_idx_))]])


# %%
#sfs lr acc
clf.fit(X_train[:,list(sfs1.k_feature_idx_)],y_train)
y_sfs_pred = clf.predict(X_test[:,list(sfs1.k_feature_idx_)])
print("Accuracy on test data set:",acc(y_sfs_pred,y_test))


# %%
clf.fit(X_train[:,:],y_train)
y_all_pred = clf.predict(X_test[:,:])
print("Accuracy on test data set using all features:",acc(y_all_pred,y_test))

# %% [markdown]
# ## Now working with only offensive stats from 1979

# %%
# Read data
df = pd.read_csv('completeFinalDatasetFrom79_OnlyO_Pruned.csv', sep=',')
df = df.drop(['Year','TeamA','TeamB'],axis=1)
df['WL'] = df['WL'].apply(result_to_numeric)
print(df.head())
print(df.columns)


# %%
# Train/test split
X_train_large, X_test_large, y_train_large, y_test_large = train_test_split(
    df.values[:,:-1],
    df.values[:,-1],
    test_size=0.30,
    random_state=42,
    shuffle=False)

y_train_large = y_train_large.astype('int')
y_test_large = y_test_large.astype('int')


# %%
sfs2 = sfs(clf,
           k_features='best',
           scoring='accuracy',
           forward=True,
           verbose=2,
           cv=tscv(n_splits = 5),
           floating=True)

#Perform SFFS
sfs2 = sfs2.fit(X_train_large, y_train_large)


# %%
print("Best accuracy by sfs:", sfs2.k_score_)
print("Indices selected by sfs:", sfs2.k_feature_idx_)
print("List of indices selected:", df.columns[[x for x in (list(sfs2.k_feature_idx_))]])


# %%
#sfs lr acc
clf.fit(X_train_large[:,list(sfs2.k_feature_idx_)],y_train_large)
y_sfs_pred_large = clf.predict(X_test_large[:,list(sfs2.k_feature_idx_)])
print("Accuracy on test data:", acc(y_sfs_pred_large,y_test_large))


# %%
clf.fit(X_train_large[:,:],y_train_large)
y_all_pred_large = clf.predict(X_test_large[:,:])
print("Accuracy on test data set using all features:",acc(y_all_pred_large,y_test_large))

# %% [markdown]
# ## Now working with offensive and defensive stats from 1979

# %%
# Read data
df = pd.read_csv('completeFinalDatasetFrom79_Pruned.csv', sep=',')
df = df.drop(['Year','TeamA','TeamB'],axis=1)
df['WL'] = df['WL'].apply(result_to_numeric)
print(df.head())
print(df.columns)


# %%
# Train/test split
X_train_complete, X_test_complete, y_train_complete, y_test_complete = train_test_split(
    df.values[:,:-1],
    df.values[:,-1],
    test_size=0.30,
    random_state=42,
    shuffle=False)

y_train_complete = y_train_complete.astype('int')
y_test_complete = y_test_complete.astype('int')


# %%
# Build step forward feature selection

sfs3 = sfs(clf,
           k_features='best',
           scoring='accuracy',
           forward=True,
           verbose=2,
           floating=False,
           cv=tscv(n_splits = 5))

#Perform SFFS
sfs3 = sfs3.fit(X_train_complete, y_train_complete)


# %%
print("Best accuracy by sfs:", sfs3.k_score_)
print("Indices selected by sfs:", sfs3.k_feature_idx_)
print("List of indices selected:", df.columns[[x for x in (list(sfs3.k_feature_idx_))]])


# %%
#sfs lr acc
clf.fit(X_train_complete[:,list(sfs3.k_feature_idx_)],y_train_complete)
y_sfs_pred_complete = clf.predict(X_test_complete[:,list(sfs3.k_feature_idx_)])
print("Accuracy on test data:", acc(y_sfs_pred_complete,y_test_complete))


# %%
clf.fit(X_train_complete[:,:],y_train_complete)
y_all_pred_complete = clf.predict(X_test_complete[:,:])
print("Accuracy on test data set using all features:",acc(y_all_pred_complete,y_test_complete))


# %%



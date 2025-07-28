# 7
import numpy as np
import pandas as pd

scores = np.random.randint(35,101, size=20)
print("Scores: \n", scores)
# 7.a
above75 = np.sum(scores >= 75)
print("Student scores above 75: ", above75)

# 7.b
mean = np.mean(scores)
print("Mean score: ", mean)
stddev = np.std(scores)
print("Standard deviation: ", stddev)

# 7.c
df = pd.DataFrame({'Score': scores})
df.to_csv('data/scores.csv', index = False)
print('Scores CSV file created.')



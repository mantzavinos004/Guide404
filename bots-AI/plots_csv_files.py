# A simple program that takes a csv file with a lot of 3D points and plot it, to find out tha the 1D around the 1 is flat. So you
# plot only those points to take a QR.

import pandas as pd
import plotly_express as px
import matplotlib.pyplot as plt

df = pd.read_csv(r"D:\.......\filename.csv")


# Uses plotly to plot a 3d "interactive" image (very impressive)
fig = px.scatter_3d(df,x='x',y='y',z='z', color='label', opacity=0.7)
fig.show()


# Uses matplotlib.pyplot to plot only the two dimencions and find a QR from the dots
qr = df[df['label']==1]

plt.figure(figsize=(6,6))
plt.scatter(qr['x'], qr['y'], s=400 ,c='black')
plt.gca().invert_yaxis()
plt.axis('off')
plt.tight_layout()
plt.savefig("qr.png")
plt.show()

import open3d as o3d
import numpy as np
import os

folder = "savepoint/Wineholder/output/point/"
files = os.listdir(folder)
l = []
count = 0
for filename in files:
	count = count + 1
	if count > 50:
		break
	print(count,filename)
	pcd = o3d.io.read_point_cloud(folder + filename)
	print(pcd,type(pcd))
	l = l + [pcd]
#print(l)
#print(np.asarray(pcd.points))
p = o3d.visualization.draw_geometries(l)

'''

with o3d.utility.VerbosityContextManager(
        o3d.utility.VerbosityLevel.Debug) as cm:
    labels = np.array(pcd.cluster_dbscan(eps=0.02, min_points=10, print_progress=True))

max_label = labels.max()
print(f"point cloud has {max_label + 1} clusters")
colors = plt.get_cmap("tab20")(labels / (max_label if max_label > 0 else 1))
colors[labels < 0] = 0
pcd.colors = o3d.utility.Vector3dVector(colors[:, :3])
o3d.visualization.draw_geometries([pcd],
                                  zoom=0.455,
                                  front=[-0.4999, -0.1659, -0.8499],
                                  lookat=[2.1813, 2.0619, 2.0999],
                                  up=[0.1204, -0.9852, 0.1215])
'''

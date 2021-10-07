import open3d as o3d
import numpy as np
import os

#folder = "../savepoint/Wineholder/output/point/"


filename = "../savepoint/Bike/" + 'WINEHOLDERMESH5.ply'

#filename = "../savepoint/Bike/output/VoxelColorPoints.ply"

pcd = o3d.io.read_point_cloud(filename)
print(pcd,type(pcd))
p = o3d.visualization.draw_geometries([pcd])

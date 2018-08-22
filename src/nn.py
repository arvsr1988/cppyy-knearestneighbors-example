from cppyy.gbl import std
import knn_example
from knn_example import NearestNeighbors, Point

# TODO put this in a pythonization that gets loaded in automatically
# Tell python how to print our C++ Class
Point.__repr__ = lambda self: repr(str(self.x) + ", " + str(self.y))

knn = NearestNeighbors()
points = [Point(2,0), Point(1,0), Point(0,10), Point(5,5), Point(2,5)]
knn.points = std.vector[Point](points)
result = knn.nearest(Point(2.1, 5.3), 4)
print(list(result))
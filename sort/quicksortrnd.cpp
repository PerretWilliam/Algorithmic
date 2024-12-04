#include <vector>
#include <iostream>
#include <chrono>

void quickSortRnd(std::vector<int> &vector)
{
  if (vector.size() > 1)
  {
    int pivot = vector[std::rand() % vector.size()];
    std::vector<int> v1, v2, v3;
    for (int x : vector)
    {
      if (x < pivot)
        v1.push_back(x);
      else if (x > pivot)
        v3.push_back(x);
      else // x == pivot
        v2.push_back(x);
    }

    quickSortRnd(v1);
    quickSortRnd(v3);

    vector = v1;
    vector.insert(vector.end(), v2.begin(), v2.end());
    vector.insert(vector.end(), v3.begin(), v3.end());
  }
}

size_t measure_time(std::vector<int> &vector)
{
  std::chrono::steady_clock::time_point t_start = std::chrono::steady_clock::now();

  quickSortRnd(vector);

  std::chrono::steady_clock::time_point t_end = std::chrono::steady_clock::now();
  size_t duration = std::chrono::duration_cast<std::chrono::microseconds>(t_end - t_start).count();

  return duration;
}
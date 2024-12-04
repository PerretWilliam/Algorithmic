#include <iostream>
#include <vector>
#include <cstdlib>
#include <ctime>
#include <chrono>

#include "sort.hpp"

void selection_sort(std::vector<int> &vector)
{
  for (size_t i = 0; i < vector.size(); i++)
  {
    size_t min = i;
    for (size_t j = i + 1; j < vector.size(); j++)
    {
      if (vector[j] < vector[min])
      {
        min = j;
      }
    }
    std::swap(vector[i], vector[min]);
  }
}

size_t measure_time(std::vector<int> &vector)
{
  std::chrono::steady_clock::time_point t_start = std::chrono::steady_clock::now();

  selection_sort(vector);

  std::chrono::steady_clock::time_point t_end = std::chrono::steady_clock::now();
  size_t duration = std::chrono::duration_cast<std::chrono::microseconds>(t_end - t_start).count();

  return duration;
}

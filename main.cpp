#include <cstdint>
#include <iostream>
#include <random>
#include <vector>
#include <ctime>

#include "./sort/sort.hpp"

std::vector<int> random_set(int max)
{
  std::vector<int> set;
  for (int i = 0; i < max; i++)
  {
    set.push_back(rand() % (max + 1));
  }
  return set;
}

std::vector<int> half_sorted_set(int max)
{
  std::vector<int> set;
  for (int i = 0; i < max; i++)
  {
    if (i < max / 2)
    {
      set.push_back(i);
    }
    else
    {
      set.push_back(rand() % (max + 1));
    }
  }
  return set;
}

std::vector<int> half_unsorted_set(int n)
{
  std::vector<int> set;
  for (int i = 0; i < n / 2; ++i)
  {
    set.push_back(n - i);
  }
  for (int i = n / 2; i < n; ++i)
  {
    set.push_back(rand() % (n));
  }
  return set;
}

int main(int argc, char *argv[])
{
  if (argc == 0)
  {
    std::cerr << "No argument passed as parameter." << std::endl;
    return EXIT_FAILURE;
  }

  std::vector<int> vector;
  int max = std::stoi(argv[1]);
  int selection = std::stoi(argv[2]);

  switch (selection)
  {
  case 1:
    vector = random_set(max);
    break;
  case 2:
    vector = half_sorted_set(max);
    break;
  case 3:
    vector = half_unsorted_set(max);
    break;
  default:
    return EXIT_FAILURE;
  }

  std::cout << max << " " << selection << " " << measure_time(vector) << std::endl;

  return EXIT_SUCCESS;
}

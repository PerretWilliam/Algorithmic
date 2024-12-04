#include <cstdint>
#include <iostream>
#include <random>
#include <vector>
#include <ctime>

#include "./sort/sort.hpp"

std::vector<int> ensemble_aleatoire(int max)
{
  std::vector<int> ensemble;
  for (int i = 0; i < max; i++)
  {
    ensemble.push_back(rand() % (max + 1));
  }
  return ensemble;
}

std::vector<int> ensemble_moitier_trie(int max)
{
  std::vector<int> ensemble;
  for (int i = 0; i < max; i++)
  {
    if (i < max / 2)
    {
      ensemble.push_back(i);
    }
    else
    {
      ensemble.push_back(rand() % (max + 1));
    }
  }
  return ensemble;
}

std::vector<int> ensemble_moitier_non_triee(int n)
{
  std::vector<int> ensemble;
  for (int i = 0; i < n / 2; ++i)
  {
    ensemble.push_back(n - i);
  }
  for (int i = n / 2; i < n; ++i)
  {
    ensemble.push_back(rand() % (n));
  }
  return ensemble;
}

int main(int argc, char *argv[])
{
  if (argc == 0)
  {
    std::cerr << "Pas d'arguement passé en paramètre." << std::endl;
    return EXIT_FAILURE;
  }

  std::vector<int> vector;
  int max = std::stoi(argv[1]);
  int selection = std::stoi(argv[2]);

  switch (selection)
  {
  case 1:
    vector = ensemble_aleatoire(max);
    break;
  case 2:
    vector = ensemble_moitier_trie(max);
    break;
  case 3:
    vector = ensemble_moitier_non_triee(max);
    break;
  default:
    return EXIT_FAILURE;
  }

  std::cout << measure_time(vector) << std::endl;

  return EXIT_SUCCESS;
}

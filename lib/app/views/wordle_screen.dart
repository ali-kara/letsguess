import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:letsguess/app/app_colors.dart';
import 'package:letsguess/app/data/word_list.dart';
import 'package:letsguess/app/models/letter_model.dart';
import 'package:letsguess/app/models/word_model.dart';
import 'package:letsguess/app/widgets/board.dart';
import 'package:letsguess/app/widgets/keyboard.dart';

enum GameStatus { playing, submitting, lost, won }

class WordleScreen extends StatefulWidget {
  const WordleScreen({super.key});

  @override
  State<WordleScreen> createState() => _WordleScreenState();
}

class _WordleScreenState extends State<WordleScreen> {
  GameStatus _gameStatus = GameStatus.playing;

  final List<Word> _board = List.generate(
    6,
    (_) => Word(
      letters: List.generate(
        5,
        (_) => Letter.empty(),
      ),
    ),
  );

  final List<List<GlobalKey<FlipCardState>>> _flipCardKeys = List.generate(
      6, (_) => List.generate(5, (_) => GlobalKey<FlipCardState>()));

  int _currentWordIndex = 0;

  Word? get _currentWord =>
      _currentWordIndex < _board.length ? _board[_currentWordIndex] : null;

  Word _solution = Word.fromString(
    fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase(),
  );

  final Set<Letter> _keyboardLetters = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'LETS GUESS',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            letterSpacing: 10,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Board(
            board: _board,
            flipCardKeys: _flipCardKeys,
          ),
          const SizedBox(
            height: 80,
          ),
          Keyboard(
            onKeyTapped: onKeyTapped,
            onDeleteTapped: onDeleteTapped,
            onEnterTapped: onEnterTapped,
            letters: _keyboardLetters,
          )
        ],
      ),
    );
  }

  void onKeyTapped(String val) {
    if (_gameStatus == GameStatus.playing) {
      setState(() {
        _currentWord?.addLetter(val);
      });
    }
  }

  void onDeleteTapped() {
    if (_gameStatus == GameStatus.playing) {
      setState(() {
        _currentWord?.removeLetter();
      });
    }
  }

  Future<void> onEnterTapped() async {
    if (_gameStatus == GameStatus.playing &&
        _currentWord != null &&
        !_currentWord!.letters.contains(Letter.empty())) {
      _gameStatus = GameStatus.submitting;

      for (var i = 0; i < _currentWord!.letters.length; i++) {
        final currentWordLetter = _currentWord!.letters[i];
        final currentSolutionLetter = _solution!.letters[i];

        setState(
          () {
            if (currentWordLetter == currentSolutionLetter) {
              _currentWord!.letters[i] =
                  currentWordLetter.copyWith(status: LetterStatus.correct);
            } else if (_solution.letters.contains(currentWordLetter)) {
              _currentWord!.letters[i] =
                  currentWordLetter.copyWith(status: LetterStatus.inWord);
            } else {
              _currentWord!.letters[i] =
                  currentWordLetter.copyWith(status: LetterStatus.notInWord);
            }
          },
        );

        final letter = _keyboardLetters.firstWhere(
          (element) => element.val == currentWordLetter.val,
          orElse: () => Letter.empty(),
        );

        if (letter.status != LetterStatus.correct) {
          _keyboardLetters
              .removeWhere((element) => element.val == currentWordLetter.val);
          _keyboardLetters.add(_currentWord!.letters[i]);
        }

        await Future.delayed(
            const Duration(
              milliseconds: 150,
            ),
            () =>
                _flipCardKeys[_currentWordIndex][i].currentState?.toggleCard());
      }

      _checkIfWinOrLoss();
    }
  }

  _checkIfWinOrLoss() {
    if (_currentWord!.wordString == _solution.wordString) {
      _gameStatus = GameStatus.won;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.none,
          duration: const Duration(
            days: 1,
          ),
          backgroundColor: correctColor,
          content: const Text(
            'You Win ! ',
            style: TextStyle(color: Colors.white),
          ),
          action: SnackBarAction(
            label: 'New Game',
            onPressed: _restartGame,
          ),
        ),
      );
    } else if (_currentWordIndex + 1 >= _board.length) {
      _gameStatus = GameStatus.lost;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.none,
          duration: const Duration(
            days: 1,
          ),
          backgroundColor: Colors.redAccent[200],
          content: Text(
            'You Lost ! Solution: ${_solution.wordString}',
            style: const TextStyle(color: Colors.white),
          ),
          action: SnackBarAction(
            label: 'New Game',
            onPressed: _restartGame,
          ),
        ),
      );
    } else {
      _gameStatus = GameStatus.playing;
    }

    _currentWordIndex += 1;
  }

  void _restartGame() {
    setState(() {
      _gameStatus = GameStatus.playing;
      _currentWordIndex = 0;
      _board
        ..clear()
        ..addAll(
          List.generate(
            6,
            (_) => Word(letters: List.generate(5, (_) => Letter.empty())),
          ),
        );

      _solution = Word.fromString(
        fiveLetterWords[Random().nextInt(fiveLetterWords.length)].toUpperCase(),
      );

      _flipCardKeys
        ..clear()
        ..addAll(
          List.generate(
            6,
            (_) => List.generate(5, (_) => GlobalKey<FlipCardState>()),
          ),
        );

      _keyboardLetters.clear();
    });
  }
}

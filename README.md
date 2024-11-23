# ミニ単語ゲーム

アルファベットを入力し、制限回数までに「\_」で隠された単語のすべてのアルファベットを当てるゲームです。<br>
残り失敗可能数が「0」になる前にすべての「\_」を開放すれば、ゲームクリアです。

![c866af5282fe1db852f169cd089343e5](https://github.com/user-attachments/assets/7c0aac4b-cc60-4e1b-87ce-a4eb011a9eca)

## 遊び方

1. **「環境構築方法」から環境構築後、コンテナ内で以下のコマンドを実行すると、ゲームがはじまります**

```
ruby src/game_start.rb
```

2. **アルファベットを 1 文字入力し、入力した文字が解答に含まれていたら、その文字に合致する「\_」が開放されます**<br>
   例）解答が「rabbit」という単語だった場合に<br>
   ![7ae9f8061817279e41bbfd2508eb86cd](https://github.com/user-attachments/assets/aa202de3-281b-42a6-bb5f-be1bf9bdf2b0)
3. **2 を繰り返し、残り失敗可能数が「0」になる前にすべての「\_」を開放すれば、ゲームクリアです**

## 環境構築方法

※ Docker Desktop が起動している状態で確認してください

1. **ミニ単語ゲームのディレクトリを `git clone` 後、`mini_word_game` ディレクトリに移動します**
2. **以下のコマンドを実行し、アプリの環境用のコンテナを構築します**

```
docker compose up -d
```

3. **2 が実行できたら、以下のコマンドを実行し、コンテナ内に入れることを確認します**

```
docker compose exec app bash
```

4. **コンテナのルートディレクトリで以下のコマンドを実行し、ゲームが開始されることを確認してください**

```
ruby src/game_start.rb
```

## テストの実行方法

## 改善点

- **`Faker` を使用して、英単語をランダムに選択できるようにする**<br>
  当初は、コード上で配列を持たず、`Faker::Creature::Animal` から動物の英単語をランダムに選択させることを考えていた。<br>
  データの種類によっては文字数の制限ができるものもあったが、`Faker::Creature` の場合は返ってくる文字数の制限ができず、複雑な英単語や記号の入った英単語が返ってくる可能性があったため断念した。

- **コンソール上で入力を行わず、`command + c` などで処理を強制終了すると、エラーが返ってきてしまう**<br>
  時間に余裕があれば、コンソールを終了した場合の処理やゲームを中断するときの処理を追加したい。<br>
  <img width="451" alt="05438e07db409f2c1b11e6e0190b04a2" src="https://github.com/user-attachments/assets/011b3281-da2e-416b-95c6-408940e7df5f">

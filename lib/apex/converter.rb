#!/usr/bin/ruby
# -*- coding: utf-8 -*-
module Apex
  module Converter
    #
    # ApexコードをJavaDocが解釈できるJavaコードに変換します。
    #
    # ApexとJavaのコード仕様の違いをなるべく吸収し、JavaDocで解釈可能なスケルトン
    # コードとして出力します。主な相違点は下記のとおりです。
    #
    # - 文字列リテラル
    # Javaではシングルクオーテーションで囲まれた文字列は1つの文字のみをあらわし
    # ますがApexではシングルクオートで文字列を表現します。そのためApexコード中
    # のすべての文字列リテラルはJavaの規則に沿うようにダブルクオーテーションに
    # 置換されます。
    #
    # - virtual with/without sharing 修飾
    # - override 修飾
    #
    def to_java
      result = ""
      in_comment = false
      @code.each_line do |line|
        #-----------------------------------------------------------------------
        # Javaで解釈できないコードを削除する
        #-----------------------------------------------------------------------
        line.chomp!
        line.gsub!(/\"/,"\\\"")
        line.gsub!(/\'/,"\"")
        line.sub!(/global /,'public ')
        line.sub!(/virtual /,'')
        line.sub!(/with /,'')
        line.sub!(/without /,'')
        line.sub!(/sharing /,'')
        line.sub!(/override /,'')
        line.gsub!(/ string /, ' String ')
        line.gsub!(/ integer /, ' Integer ')
        line.gsub!(/Class/, 'class')
        line.gsub!(/MAP/, 'Map')
        if line =~ /\/\//
          line.sub!(/\/\//,'/*')
          line += "*/"
        end
        #-----------------------------------------------------------------------
        # コメントモードの場合、改行を付加して出力行内にコメント終了トークンが
        # ある場合はコメントモードを終了する
        #-----------------------------------------------------------------------
        if in_comment
          in_comment = false if line =~ R_COMMENT_END
          result += line + "\n"
        else
        #-----------------------------------------------------------------------
        # コメントモードでないときに、行内にコメント開始がある場合コメントモー
        # ドを開始し改行を付加して出力
        #-----------------------------------------------------------------------
          if line =~ R_COMMENT_START
            in_comment = true unless line =~ R_COMMENT_END
            result += line + "\n"
          else
        #-----------------------------------------------------------------------
        # コメントモードでなく行内にコメント開始がない場合、クラス、メソッド、
        # フィールドのいずれかであるか判定する
        #-----------------------------------------------------------------------
        ## クラス定義の場合、改行を付加して出力
        #-----------------------------------------------------------------------
            if line =~ R_DEF_CLASS
              if line =~ /\{/
                line = line + "\n"
              else
                line = line + "{\n"
              end
              result += line
        #-----------------------------------------------------------------------
        ## コンストラクタ定義の場合、中括弧を閉じて出力
        #-----------------------------------------------------------------------
            elsif line =~ R_DEF_CONSTRACTOR
              if line =~ /\}/
                line = line + "\n"
              else
                line = line + "}\n"
              end
              result += line
        #-----------------------------------------------------------------------
        ## メソッド定義の場合、抽象メソッドは改行を付加して出力する
        ## メソッドの型がvoidの場合は中括弧を閉じそれ以外の場合はnullを返すコー
        ## ドを付加して出力
        #-----------------------------------------------------------------------
            elsif line =~ R_DEF_METHOD
              unless $2 =~ /abstract/
                if $3 == "void"
                   if line =~ /\}/
                     line = line + "\n"
                   else
                     line = line + "}\n"
                   end
                else
                   if line =~ /\}/
                     line = line + "\n"
                   else
                     line = line + "return null;}\n"
                   end
                end
              end
              result += line
        #-----------------------------------------------------------------------
        ## フィールド定義の場合、改行を付加して出力
        #-----------------------------------------------------------------------
            elsif line =~ R_DEF_FIELD
              result += line + "\n"
            end
          end
        end
      end
      result + "\n}\n"
    end
  end
end
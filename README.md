# xiaohuoshuan123.github.io

小火山的个人博客，托管在 [GitHub Pages](https://pages.github.com/)。

## 结构

```
.
├── _config.yml          # Jekyll 站点配置
├── _layouts/
│   └── home.html        # 自定义首页布局
├── assets/
│   └── css/
│       └── style.scss   # 自定义样式（火山主题）
├── index.md             # 首页（Hero + 活动 + 关于）
├── quiz.html            # 答题有礼页面
└── push_blog.sh         # 一键推送部署脚本
```

## 设计

- **配色**：火山主题（暖橙 + 深红 + 奶油底）
- **风格**：现代极简、卡片式布局、微动效
- **响应式**：适配桌面端和移动端

## 部署

GitHub Pages 自动部署：推送到 `main` 分支根目录即可生效，约 1-2 分钟后访问
`https://xiaohuoshuan123.github.io`。

```bash
# 一键推送
export GITHUB_TOKEN=$(cat /c/Users/Administrator/github_token.txt | tail -1)
bash push_blog.sh
```

## 本地预览

```bash
gem install bundler jekyll
jekyll serve
# 访问 http://localhost:4000
```

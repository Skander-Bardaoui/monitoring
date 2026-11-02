<p align="center">
  <img src="docs/banner.svg" width="100%" alt="K8s Monitoring Stack banner" />
</p>

<p align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=22&pause=1200&color=64748B&center=true&vCenter=true&width=760&lines=Metrics%2C+dashboards%2C+alerts;Prometheus+%2B+Grafana;Kubernetes-native+monitoring" alt="Typing tagline" />
</p>

<p align="center">
  <img src="https://img.shields.io/github/languages/top/Skander-Bardaoui/monitoring?style=flat-square&color=64748B" alt="" />
  <img src="https://img.shields.io/github/stars/Skander-Bardaoui/monitoring?style=flat-square&color=64748B" alt="" />
  <img src="https://img.shields.io/github/last-commit/Skander-Bardaoui/monitoring?style=flat-square&color=94A3B8" alt="" />
  <img src="https://img.shields.io/badge/status-DevOps-64748B?style=flat-square" alt="" />
</p>

## Overview

A Kubernetes monitoring stack defined entirely as manifests: Prometheus for metrics and alert rules, Grafana for dashboards, Alertmanager for routing, kube-state-metrics for cluster state and node-exporter for host metrics. A single script deploys the whole stack.

## Highlights

- Prometheus deployment with scrape configuration and alert rules
- Grafana deployment with provisioned datasources and dashboards
- Alertmanager routing configuration
- kube-state-metrics and node-exporter
- One-command deployment script

## Tech stack

<p align="center">
  <img src="https://skillicons.dev/icons?i=kubernetes,docker,linux,bash,git&theme=dark&perline=8" alt="Tech stack" />
</p>

## Getting started

**Prerequisites:** A Kubernetes cluster and kubectl configured against it.

```bash
chmod +x deploy-all.sh
./deploy-all.sh
kubectl get pods -A
```

## Project structure

```text
prometheus/          deployment, config, alert rules
grafana/             deployment and dashboard provisioning
alertmanager/        deployment and routing config
kube-state-metrics/  cluster metrics
node-exporter/       host metrics
deploy-all.sh        applies every manifest
```

---

<p align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=0:64748B,100:0A0A0C&height=110&section=footer" alt="footer" width="100%" />
</p>

<p align="center">
  Built by <a href="https://github.com/Skander-Bardaoui"><b>Skander Bardaoui</b></a> ·
  <a href="https://skander-bardaoui.netlify.app/">Portfolio</a> ·
  <a href="https://github.com/Skander-Bardaoui?tab=repositories">All repositories</a>
</p>

#!/bin/bash

# ═══════════════════════════════════════════════════════════════════════════
# SCRIPT DE DÉPLOIEMENT COMPLET DU MONITORING
# ═══════════════════════════════════════════════════════════════════════════

set -e

echo "╔════════════════════════════════════════════════════════════╗"
echo "║     🚀 DÉPLOIEMENT DU STACK DE MONITORING COMPLET         ║"
echo "╚════════════════════════════════════════════════════════════╝"

# Couleurs pour les logs
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Fonction pour afficher les messages
log_info() {
    echo -e "${GREEN}✓${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}⚠${NC} $1"
}

log_error() {
    echo -e "${RED}✗${NC} $1"
}

# Vérifier que kubectl est installé
if ! command -v kubectl &> /dev/null; then
    log_error "kubectl n'est pas installé. Veuillez l'installer d'abord."
    exit 1
fi

log_info "kubectl trouvé: $(kubectl version --client --short)"

# Créer le namespace monitoring
echo ""
echo "📦 Création du namespace monitoring..."
kubectl create namespace monitoring --dry-run=client -o yaml | kubectl apply -f -
log_info "Namespace monitoring créé/vérifié"

# Déployer Prometheus
echo ""
echo "📊 Déploiement de Prometheus..."
kubectl apply -f prometheus/prometheus-config.yaml
kubectl apply -f prometheus/alert-rules.yaml
kubectl apply -f prometheus/deployment.yaml
log_info "Prometheus déployé"

# Déployer Alertmanager
echo ""
echo "🔔 Déploiement d'Alertmanager..."
kubectl apply -f alertmanager/alertmanager-config.yaml
kubectl apply -f alertmanager/deployment.yaml
log_info "Alertmanager déployé"

# Déployer Grafana
echo ""
echo "📈 Déploiement de Grafana..."
kubectl apply -f grafana/grafana-config.yaml
kubectl apply -f grafana/deployment.yaml
log_info "Grafana déployé"

# Déployer Node Exporter
echo ""
echo "🖥️  Déploiement de Node Exporter..."
kubectl apply -f node-exporter/daemonset.yaml
log_info "Node Exporter déployé"

# Déployer Kube State Metrics
echo ""
echo "📊 Déploiement de Kube State Metrics..."
kubectl apply -f kube-state-metrics/deployment.yaml
log_info "Kube State Metrics déployé"

# Attendre que les pods soient prêts
echo ""
echo "⏳ Attente du démarrage des pods..."
sleep 10

# Vérifier le statut des déploiements
echo ""
echo "🔍 Vérification du statut des déploiements..."
kubectl rollout status deployment/prometheus -n monitoring --timeout=300s
kubectl rollout status deployment/alertmanager -n monitoring --timeout=300s
kubectl rollout status deployment/grafana -n monitoring --timeout=300s
kubectl rollout status deployment/kube-state-metrics -n monitoring --timeout=300s

# Afficher les pods
echo ""
echo "📦 Pods dans le namespace monitoring:"
kubectl get pods -n monitoring

# Afficher les services
echo ""
echo "🔌 Services dans le namespace monitoring:"
kubectl get svc -n monitoring

# Afficher les URLs d'accès
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║              ✅ DÉPLOIEMENT TERMINÉ AVEC SUCCÈS            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo "📍 URLs d'accès (remplacez <NODE_IP> par l'IP de votre nœud):"
echo ""
echo "  🔹 Prometheus:    http://<NODE_IP>:30090"
echo "  🔹 Grafana:       http://<NODE_IP>:30030"
echo "  🔹 Alertmanager:  http://<NODE_IP>:30093"
echo ""
echo "🔐 Credentials Grafana:"
echo "  Username: admin"
echo "  Password: admin123"
echo ""
echo "💡 Pour obtenir l'IP du nœud:"
echo "  kubectl get nodes -o wide"
echo ""
log_info "Stack de monitoring déployé avec succès!"

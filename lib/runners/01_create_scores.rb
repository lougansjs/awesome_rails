# frozen_string_literal: true

artia = [['Tradução', 1, 1], ['Layout', 1, 1], ['Validação de Campo', 1, 1], ['Tela Nova (Add, Show, Edit, Del)', 2, 2], ['Visão (Inclusão de novo campo)', 1, 1], ['Campos Customizados', 2, 2], ['Listagem', 1, 1], ['Relatórios', 2, 1], ['Link Público', 1, 2], ['Modelo de Projeto', 3, 1], ['Timeline / Aba objeto', 1, 2], ['Alocação de Equipe', 5, 3], ['Gantt Avançado', 3, 2], ['Importação XML', 1, 2], ['Exportação XML', 1, 1], ['Importação CSV', 2, 2], ['Exportação CSV', 2, 2], ['Kanban (Visão)', 2, 2], ['Kanban', 5, 1], ['Apontamentos', 3, 2], ['Arquivos', 1, 1], ['Permissões', 3, 2], ['Cálculo', 3, 3], ['Linha de Base', 3, 2], ['Última Linha de Base', 1, 1], ['Float', 3, 1], ['API (Add, Edit, Del, Show', 5, 3], ['Views de BI', 1, 1], ['Pagamentos/Planos', 5, 3], ['Atividade Recorrente', 5, 2], ['Gestão de Contrato', 5, 2]]

twygo = [['Dashboard', 2, 2], ['Tela Nova (Add, Show, Edit, Del)', 2, 3], ['Catálogo de Cursos (Dados/Página)', 5, 2], ['Certificado', 8, 2], ['Aprovação', 2, 2], ['Conteúdo', 2, 2], ['Texto', 1, 1], ['PDF Estampado', 2, 3], ['Vídeo', 3, 3], ['Vídeo Externo', 3, 2], ['Arquivos', 2, 3], ['Questionário', 2, 3], ['Scorm', 2, 5], ['Webinar', 2, 2], ['Instrutor', 2, 2], ['Fóruns', 1, 3], ['Parceiro', 2, 2], ['Grupos de Trabalho', 1, 1], ['Lista de Cursos', 3, 2], ['Inscrição', 8, 3], ['Pagamento - Inscrição', 1, 3], ['Pagamento', nil, 3], ['Importação', 8, 3], ['Alunos', 5, 3], ['Alunos (Pontuação)', 3, nil], ['Divulgar', 1, 1], ['Gestores de Turma', 2, 2], ['Biblioteca', 2, 1], ['Trilha', 3, 3], ['Usuários', 5, 3], ['Questionário', 3, 5], ['Fóruns (Trilha)', 5, 3], ['Dados da Organização', 3, 3], ['Customização', 8, 3], ['Termos', 1, 1], ['Integrações', 3, 3], ['URL', 1, 1], ['Regras do Jogo', 3, 3], ['Plugins', 3, 1], ['Configuração de Pagamentos', 1, 1], ['Cupons e Vouchers', 2, 3], ['Parceiras', 2, 2], ['Tradução', 1, 1], ['Layout', 1, 1], ['Configuração do Usuário', 5, 2], ['API', 8, 3], ['Link Externo', 5, 2]]

fleeg = [['Dashboard', 1, 1], ['Novos gráficos', 2, 3], ['Tela Nova (Add, Show, Edit, Del)', 2, 2], ['Kanban', 1, 2], ['Pessoa', 1, 2], ['Auditoria', 2, 1], ['Organizações', 1, 2], ['Oportunidade', 3, 2], ['Gerar proposta', 3, 2], ['Produtos', 1, 3], ['Histórico', 2, 2], ['Documento', 1, 1], ['Eventos', 2, 1], ['Estatística', 1, 1], ['Gerar pedido', 3, 1], ['Duplicar', 2, 2], ['Tarefas', 2, 2], ['Exportação CSV/XLS', 3, 1], ['Importação CSV/XLS', 3, 2], ['Automação', 5, 5], ['Landing Page', 1, 3], ['Permissões', 1, 1], ['Empresa', 1, 1], ['Ciclo de Vendas', 2, 2], ['Integrações', 3, 3], ['Cadastro de Produtos', 1, 2], ['Novas Notificações', 2, 2], ['Motivo de perda', 1, 1], ['Lead Scoring', 1, 1], ['Campo Customizado', 2, 2], ['Tradução', 1, 1], ['Layout', 1, 1], ['Validação de Campo', 1, 1], ['Modal de Confirmação', 1, 1]]

artia.each do |title, dev_points, qa_points|
  Score.create(title: title, dev_points: dev_points, qa_points: qa_points, app_id: 1)
end

twygo.each do |title, dev_points, qa_points|
  Score.create(title: title, dev_points: dev_points, qa_points: qa_points, app_id: 2)
end

fleeg.each do |title, dev_points, qa_points|
  Score.create(title: title, dev_points: dev_points, qa_points: qa_points, app_id: 3)
end

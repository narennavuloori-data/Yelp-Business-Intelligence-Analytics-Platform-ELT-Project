from pathlib import Path
import re
import sys

ROOT = Path(__file__).resolve().parents[1]
TEXT_SUFFIXES = {'.md', '.txt', '.sql', '.py', '.json', '.yml', '.yaml', '.dax', '.env', '.example'}
IGNORE_PARTS = {'.git', '.venv', 'venv', '__pycache__'}

patterns = {
    'AWS access key': re.compile(r'AKIA[0-9A-Z]{16}'),
    'AWS secret assignment': re.compile(r'AWS_SECRET(?:_ACCESS)?_KEY\s*=\s*[\'\"][^\'\"]{20,}[\'\"]', re.IGNORECASE),
}

findings = []

for path in ROOT.rglob('*'):
    if not path.is_file():
        continue
    if any(part in IGNORE_PARTS for part in path.parts):
        continue
    if path.suffix.lower() not in TEXT_SUFFIXES and path.name != '.env.example':
        continue

    try:
        text = path.read_text(encoding='utf-8')
    except UnicodeDecodeError:
        continue

    for label, pattern in patterns.items():
        for match in pattern.finditer(text):
            line_number = text.count('\n', 0, match.start()) + 1
            findings.append(f'{path.relative_to(ROOT)}:{line_number} - {label}')

if findings:
    print('Potential secrets found:')
    for finding in findings:
        print(f'  {finding}')
    sys.exit(1)

print('No hard-coded AWS credentials were found.')
